import UIKit

fileprivate var hookSet = false
fileprivate let snapTag = 345678934
fileprivate var _dismissModalAsGrouped = false


extension UIViewController {

    private func addSnap() {
        if self.presentedViewController?.presentedViewController != nil {

            if let presentedViewController = self.presentedViewController,
               let window = self.view.window,
               !presentedViewController.view.subviews.contains(where: { $0.tag == snapTag }),
               presentedViewController.view.convert(presentedViewController.view.bounds, to: window) == window.bounds {

                let rc = presentedViewController.view.convert(presentedViewController.view.bounds, to: window).applying(.init(scaleX: window.screen.scale, y: window.screen.scale))

                let renderer = UIGraphicsImageRenderer(bounds: window.bounds)
                let image = renderer.image { rendererContext in
                    window.layer.render(in: rendererContext.cgContext)
                }

                if let drawImage = image.cgImage!.cropping(to: rc) {

                    let newImage = UIImage(cgImage: drawImage)
                    let snap = UIImageView(image: newImage)

                    snap.frame = presentedViewController.view.bounds
                    snap.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    snap.tag = snapTag
                    presentedViewController.view.addSubview(snap)
                }
            }
        }
    }

    @objc(dismissGroupedViewControllerAnimated:completion:)
    open func dismissGrouped(animated flag: Bool, completion: (() -> Void)? = nil) {
        addSnap()
        dismiss(animated: flag, completion: completion)
    }

    @objc func GroupedControllerDismissal_dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {

        if UIViewController.dismissModalAsGrouped {
            addSnap()
        }

        GroupedControllerDismissal_dismiss(animated: flag, completion: completion)
    }

    @objc public var dismissModalAsGrouped: Bool {
        get {
            objc_getAssociatedObject(self, &_dismissModalAsGrouped) as? Bool ?? false
        }
        set {
            if newValue {
                type(of: self).hook()
            }
            objc_setAssociatedObject(self, &_dismissModalAsGrouped, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc public static var dismissModalAsGrouped: Bool {
        get {
            return _dismissModalAsGrouped
        }
        set  {
            if newValue {
                hook()
            }
            _dismissModalAsGrouped = newValue
        }
    }

    fileprivate static func hook() {

        guard !hookSet else {
            return
        }

        hookSet = true

        let originalSelector = #selector(UIViewController.dismiss(animated:completion:))
        let swizzledSelector = #selector(UIViewController.GroupedControllerDismissal_dismiss(animated:completion:))

        let instanceClass = UIViewController.self
        let originalMethod = class_getInstanceMethod(instanceClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(instanceClass, swizzledSelector)

        let didAddMethod = class_addMethod(instanceClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))

        if didAddMethod {
            class_replaceMethod(instanceClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }

}

