#if canImport(UIKit) && DEBUG
import UIKit

extension UIViewController {
    public static func install() {
        let originalSelector = #selector(UIViewController.viewDidAppear(_:))
        let swizzledSelector = #selector(UIViewController.swizzled_viewDidAppear(_:))

        let originalMethod = class_getInstanceMethod(UIViewController.self, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(UIViewController.self, swizzledSelector)!

        method_exchangeImplementations(originalMethod, swizzledMethod)
    }

    @objc
    func swizzled_viewDidAppear(_ animated: Bool) {
        swizzled_viewDidAppear(animated)
        try? DungeonMapTracker.shared.record(for: self)
    }
}

extension UIViewController {
    func printHierarchy() -> String? {
        let selector = Selector(("_printHierarchy"))
        guard responds(to: selector) else {
            return nil
        }
        let returnValue = perform(selector)
        let unretainedValue = returnValue?.takeUnretainedValue()
        let printHierarchy = unretainedValue as? String
        return printHierarchy
    }
}
#endif
