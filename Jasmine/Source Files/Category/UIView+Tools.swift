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
    
    func isSubview(of view: UIView) -> Bool {
        var tempSuperview: UIView? = self
        while tempSuperview != nil {
            if tempSuperview! === view {
                return true
            }
            tempSuperview = tempSuperview?.superview
        }
        return false
    }
    
    func isSuperview(of view: UIView) -> Bool {
        var tempSuperview: UIView? = view
        while tempSuperview != nil {
            if tempSuperview! === self {
                return true
            }
            tempSuperview = tempSuperview?.superview
        }
        return false
    }
    
}

// MARK: - 色彩变化

public extension UIView {
    
    func startGlowing(with color: UIColor = .white, fromOpacity: CGFloat = 0.08, toOpacity: CGFloat = 0.6, duration: CGFloat = 1.0) {
        guard superview?.viewWithTag(3141592653589793238) == nil else { return }
        let glowingView = UIView(frame: frame)
        glowingView.tag = 3141592653589793238
        glowingView.backgroundColor = color
        superview?.insertSubview(glowingView, aboveSubview: self)

        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = fromOpacity
        animation.toValue = toOpacity
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.duration = CFTimeInterval(duration)
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        glowingView.layer.add(animation, forKey: "pulse")
    }

    func stopGlowing() {
        var glowingView = superview?.viewWithTag(3141592653589793238)
        glowingView?.removeFromSuperview()
        glowingView = nil
    }
    
}
