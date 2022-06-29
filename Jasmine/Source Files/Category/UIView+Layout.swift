//
//  UIView+Layout.swift
//  Jasmine
//
//  Created by ebamboo on 2022/6/29.
//

import UIKit

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

public extension UIView {

    // MARK: - 只读属性
    
    var boundsCenter: CGPoint {
        return CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
    }
    
    var safeArea: CGRect {
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
