public struct PrintHierarchy: Sendable {
    public let lines: [PrintHierarchyLine]
}

public struct PrintHierarchyLine: Sendable {
    public let header: Header
    public let controller: Controller
    public let state: State
    public let view: View
    
    public struct Header: Sendable {
        public var positions: [Position] = []
    }
    public struct Controller: Sendable {
        public var name: String
        public var address: String
    }
    public enum State: String, Sendable {
        case appeared
        case appearing
        case disappeared
        case disappearing
    }
    public enum View: Equatable, Sendable {
        case notLoaded
        case loaded(_ name: String, _ address: String, _ notInTheWindow: Bool)
    }
    public enum Position: Sendable {
        case child
        case presented
    }
}

