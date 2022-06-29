//
//  UIView+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/25.
//

import UIKit

// MARK: - 层次关系

public extension UIView {
    
    var viewController: UIViewController? {
        var nextResponder = next
        while nextResponder != nil {
            if nextResponder!.isKind(of: UIViewController.self) {
                return nextResponder as? UIViewController
            }
            nextResponder = nextResponder?.next
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
