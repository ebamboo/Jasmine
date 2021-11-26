//
//  OrientationButton.swift
//  SwiftDK
//
//  Created by ebamboo on 2021/11/24.
//

import UIKit

/// 自由控制 UIButton 的 image 和 text 位置和间距
class OrientationButton: UIButton {

    enum Orientation: Int {
        case LandscapeLeft      = 0 ///  图片在左
        case LandscapeRight     = 1 ///  图片在右
        case Portrait           = 2 ///  图片在上
        case UpsideDown         = 3 ///  图片在下
    }
    
    var orientation: Orientation = .LandscapeLeft
    @IBInspectable var orientationInt: Int {
        get { orientation.rawValue }
        set { orientation = Orientation(rawValue: newValue) ?? .LandscapeLeft }
    }
    @IBInspectable var spacing: CGFloat = 0.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutImageAndText()
    }
    
    private func layoutImageAndText() {
        switch orientation {
        case .LandscapeLeft:
            titleEdgeInsets = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: 0,
                right: -spacing/2
            )
            imageEdgeInsets = UIEdgeInsets(
                top: 0,
                left: -spacing/2,
                bottom: 0,
                right: 0
            )
        case .LandscapeRight:
            titleEdgeInsets = UIEdgeInsets(
                top: 0,
                left: -2*(imageView?.frame.size.width ?? 0) - spacing,
                bottom: 0,
                right: 0
            )
            imageEdgeInsets = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: 0,
                right: -2*(titleLabel?.frame.size.width ?? 0) - spacing
            )
        case .Portrait:
            titleEdgeInsets = UIEdgeInsets(
                top: 0,
                left: -(imageView?.frame.size.width ?? 0),
                bottom: -(imageView?.frame.size.height ?? 0) - spacing/2,
                right: 0
            )
            imageEdgeInsets = UIEdgeInsets(
                top: -(titleLabel?.intrinsicContentSize.height ?? 0) - spacing/2,
                left: 0,
                bottom: 0,
                right: -(titleLabel?.intrinsicContentSize.width ?? 0)
            )
        case .UpsideDown:
            titleEdgeInsets = UIEdgeInsets(
                top: -(imageView?.frame.size.width ?? 0) - spacing/2,
                left: -(imageView?.frame.size.width ?? 0),
                bottom: 0,
                right: 0
            )
            imageEdgeInsets = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: -(titleLabel?.intrinsicContentSize.height ?? 0) - spacing/2,
                right: -(titleLabel?.intrinsicContentSize.width ?? 0)
            )
        }
    }

}
