public import Foundation
import RegexBuilder

public struct PrintHierarchyDecoder {
    
    public init() {}
    
    public func decodeAsNode(from data: Data) throws -> RootNode {
        let object = try decode(from: data)
        let rootNode = RootNode(object)
        return rootNode
    }
    
    public func decode(from data: Data) throws -> PrintHierarchy {
        guard let text = String(data: data, encoding: .utf8) else {
            throw HierarchyDataDecoderError.dataCorrupted
        }
        let lines = text.split(separator: .newlineSequence)
        return PrintHierarchy(
            lines: try lines.map(decode(line:))
        )
    }
    
    internal func decode(line: Substring) throws -> PrintHierarchyLine {
        let header = Reference<PrintHierarchyLine.Header>()
        let controllerName = Reference<Substring>()
        let controllerAddress = Reference<Substring>()
        let state = Reference<PrintHierarchyLine.State>()
        let view = Reference<PrintHierarchyLine.View>()
        let regex = Regex {
            headerRegex(as: header)
            controllerRegex(name: controllerName, address: controllerAddress)
            ", "
            stateRegex(state: state)
            ", "
            viewRegex(view: view)
            ZeroOrMore {
                .any
            }
        }
        guard let match = line.wholeMatch(of: regex) else {
            throw HierarchyDataDecoderError.invalidFormat
        }
        return PrintHierarchyLine(
            header: match[header],
            controller: PrintHierarchyLine.Controller(
                name: String(match[controllerName]),
                address: String(match[controllerAddress])
            ),
            state: match[state],
            view: match[view]
        )
    }
    
    func viewRegex(
        view: Reference<PrintHierarchyLine.View> = Reference<PrintHierarchyLine.View>()
    ) -> some RegexComponent {
        Regex {
            "view: "
            Capture(as: view) {
                ChoiceOf {
                    "(view not loaded)"
                    Regex {
                        "<"
                        OneOrMore {
                            ChoiceOf {
                                .word
                                "$"
                                "."
                            }
                        }
                        ": "
                        "0x"
                        OneOrMore {
                            .hexDigit
                        }
                        ">"
                        Optionally {
                            " not in the window"
                        }
                    }
                }
            } transform: {
                switch String($0) {
                case "(view not loaded)":
                    return PrintHierarchyLine.View.notLoaded
                default:
                    let name = Reference<Substring>()
                    let address = Reference<Substring>()
                    let notInTheWindow = Reference<Bool>()
                    let match = $0.wholeMatch(of: viewRegex(name: name, address: address, notInTheWindow: notInTheWindow))!
                    return PrintHierarchyLine.View.loaded(String(match[name]), String(match[address]), match[notInTheWindow])
                }
            }
        }
    }
    
    func viewRegex(
        name: Reference<Substring> = Reference<Substring>(),
        address: Reference<Substring> = Reference<Substring>(),
        notInTheWindow: Reference<Bool> = Reference<Bool>()
    ) -> Regex<(Substring, Substring, Substring, Bool)> {
        Regex {
            "<"
            Capture(as: name) {
                OneOrMore {
                    ChoiceOf {
                        .word
                        "$"
                        "."
                    }
                }
            }
            ": "
            Capture(as: address) {
                "0x"
                OneOrMore {
                    .hexDigit
                }
            }
            ">"
            Capture(as: notInTheWindow) {
                Optionally {
                    " not in the window"
                }
            } transform: {
                !$0.isEmpty
            }
        }
    }
    
    func controllerRegex(
        name: Reference<Substring> = Reference<Substring>(),
        address: Reference<Substring> = Reference<Substring>()
    ) -> Regex<(Substring, Substring, Substring)> {
        Regex {
            "<"
            Capture(as: name) {
                OneOrMore {
                    ChoiceOf {
                        .word
                        "$"
                        "."
                    }
                }
            }
            " "
            Capture(as: address) {
                "0x"
                OneOrMore {
                    .hexDigit
                }
            }
            ">"
        }
    }
    
    func stateRegex(state: Reference<PrintHierarchyLine.State> = Reference<PrintHierarchyLine.State>()) -> Regex<(Substring, PrintHierarchyLine.State)> {
        Regex {
            "state: "
            Capture(as: state) {
                ChoiceOf {
                    PrintHierarchyLine.State.appeared.rawValue
                    PrintHierarchyLine.State.appearing.rawValue
                    PrintHierarchyLine.State.disappeared.rawValue
                    PrintHierarchyLine.State.disappearing.rawValue
                }
            } transform: {
                PrintHierarchyLine.State(rawValue: String($0))!
            }
        }
    }
    
    func headerRegex(as header: Reference<PrintHierarchyLine.Header> = Reference<PrintHierarchyLine.Header>()) -> Regex<(Substring, PrintHierarchyLine.Header)> {
        Regex {
            Capture(as: header) {
                ZeroOrMore {
                    ChoiceOf {
                        .whitespace
                        "|"
                        "+"
                    }
                }
            } transform: {
                var positions: [PrintHierarchyLine.Position] = []
                for character in $0 {
                    switch character {
                    case "|": positions.append(.child)
                    case "+": positions.append(.presented)
                    default: break
                    }
                }
                return PrintHierarchyLine.Header(positions: positions)
            }
        }
    }
}
