#if canImport(UIKit)
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
        
//        let isRootViewController = DungeonMapTracker.shared.window?.rootViewController == self
//        let isPresentingViewController = presentingViewController != nil
//        let isFullSizeViewController = view.frame == parent?.view.frame
//        guard isRootViewController || (isFullSizeViewController || isPresentingViewController) else { return }
        try? DungeonMapTracker.shared.record(for: self)
    }
}
#endif
