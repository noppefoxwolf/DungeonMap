#if canImport(UIKit)
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
    
    var recordedNode: RootNode = RootNode()
    
    func record(for viewController: UIViewController) throws {
        logger.debug("\(#function)")
        guard let rootViewController = window?.rootViewController else { return }
        let selector = Selector(("_printHierarchy"))
        if rootViewController.responds(to: selector) {
            let returnValue = rootViewController.perform(selector)
            let unretainedValue = returnValue?.takeUnretainedValue()
            let printHierarchy = unretainedValue as? String
            if let printHierarchy {
                let decoder = PrintHierarchyDecoder()
                do {
                    let rootNode = try decoder.decodeAsNode(from: Data(printHierarchy.utf8))
                    recordedNode = recordedNode.merged(with: rootNode, allInclusive: true)
                    print(recordedNode)
                } catch {
                    print(printHierarchy)
                    fatalError()
                }
            }
        }
        
        //        let renderer = UIGraphicsImageRenderer(bounds: view.bounds, format: .init(for: traitCollection))
        //        let image = renderer.image { context in
        //            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        //        }
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
