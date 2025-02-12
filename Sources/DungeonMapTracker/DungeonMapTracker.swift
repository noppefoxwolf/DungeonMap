#if canImport(UIKit) && DEBUG
import UIKit
import PrintHierarchyDecoder
import os

@MainActor
public final class DungeonMapTracker {
    public static let shared = DungeonMapTracker()
    
    let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: #file
    )
    
    weak var window: UIWindow? = nil
    
    var storage: [HierarchyNode] = []
    
    func record(for viewController: UIViewController) throws {
        logger.debug("\(#function)")
        guard let rootViewController = window?.rootViewController else { return }
//        let address = Unmanaged.passUnretained(viewController).toOpaque()
//        let hexAddress = String(describing: address)
//        print("Memory address: \(hexAddress)")
//        print(viewController.debugDescription)
        
        let printHierarchy = rootViewController.printHierarchy()
        if let printHierarchy {
            do {
                let decoder = PrintHierarchyDecoder()
                let rootNode = try decoder.decodeAsNode(from: Data(printHierarchy.utf8))
                storage.append(rootNode)
                printMerged()
            } catch {
                print(printHierarchy)
                fatalError()
            }
        }
        
        //        let renderer = UIGraphicsImageRenderer(bounds: view.bounds, format: .init(for: traitCollection))
        //        let image = renderer.image { context in
        //            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        //        }
    }
    
    func printMerged() {
        let output = storage.reduce(into: HierarchyNode()) { partialResult, rootNode in
            partialResult.merge(with: rootNode, by: {
                // FIXME: pushやpresentされるとこの条件だと重複除外できない
                $0.controllerName == $1.controllerName && $0.controllerAddress == $1.controllerAddress
            })
        }
        print(output)
    }
}

extension DungeonMapTracker {
    @MainActor
    public func install(window: UIWindow) {
        self.window = window
        UIViewController.install()
    }
}
#endif
