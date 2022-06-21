//
//  UIView+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/25.
//

import UIKit

// MARK: - 边角设置

public extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius;
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
}

// MARK: - 布局

public extension UIView {

    // MARK: - 只读属性
    
    var boundsCenter: CGPoint {
        return CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
    }
    
    var safeAreaFrame: CGRect {
        let rect = CGRect(
            x: safeAreaInsets.left,
            y: safeAreaInsets.top,
            width: frame.size.width - safeAreaInsets.left - safeAreaInsets.right,
            height: frame.size.height - safeAreaInsets.top - safeAreaInsets.bottom
        )
        return rect
    }
    
    // MARK: - 改变位置
    
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }

    var left: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }

    var bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set {
            frame.origin.y = newValue - frame.size.height
        }
    }

    var right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set {
            frame.origin.x = newValue - frame.size.width
        }
    }

    var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center.x = newValue
        }
    }

    var centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center.y = newValue
        }
    }

    var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            frame.origin = newValue
        }
    }

    // MARK: - 改变尺寸

    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }

    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }

    var size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }

}

// MARK: - 层次关系

public extension UIView {
    
    var viewController: UIViewController? {
        var view: UIView? = superview
        while view != nil {
            if let nextResponder = view?.next, nextResponder.isKind(of: UIViewController.self) {
                return nextResponder as? UIViewController
            }
            view = view?.superview
        }
        return nil
    }
    
    func isSubviewOfView(_ view: UIView) -> Bool {
        var tempView: UIView? = self
        while tempView != nil {
            if tempView! === view {
                return true
            }
            tempView = tempView?.superview
        }
        return false
    }
    
}

// MARK: - 毛玻璃

public extension UIView {
    
    func addEffect(style: UIBlurEffect.Style = .light) {
        let effect = UIBlurEffect(style: style)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = bounds
        addSubview(effectView)
    }
    
}

// MARK: - 色彩变化

public extension UIView {
    
    private static var GLOWVIEW = "GLOWVIEW";
    private var glowView: UIImageView? {
        get {
            return objc_getAssociatedObject(self, &UIView.GLOWVIEW) as? UIImageView
        }
        set {
            objc_setAssociatedObject(self, &UIView.GLOWVIEW, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func glowOnce(with color: UIColor = .white) {
        glow(with: color, fromIntensity: 0.1, toIntensity: 0.6, isRepeat: true, duration: 1.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.stopGlowing()
        }
    }
    
    func glow(with color: UIColor, fromIntensity: CGFloat, toIntensity: CGFloat, isRepeat: Bool, duration: CGFloat) {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        layer.render(in: context)
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        color.setFill()
        path.fill(with: .sourceAtop, alpha: 1.0)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        
        let tempGlowView = UIImageView(image: image)
        superview?.insertSubview(tempGlowView, aboveSubview: self)
        tempGlowView.center = center
        tempGlowView.alpha = 0
        tempGlowView.layer.shadowColor = color.cgColor
        tempGlowView.layer.shadowOffset = CGSize()
        tempGlowView.layer.shadowRadius = 10
        tempGlowView.layer.shadowOpacity = 1.0
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = fromIntensity
        animation.toValue = toIntensity
        animation.repeatCount = isRepeat ? 24 * 60 * 60 : 0
        animation.duration = CFTimeInterval(duration)
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        tempGlowView.layer.add(animation, forKey: "pulse")
        glowView = tempGlowView
    }
    
    func stopGlowing() {
        glowView?.removeFromSuperview()
        glowView = nil
    }
    
}
