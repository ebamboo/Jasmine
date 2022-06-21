//
//  OrientationButton.swift
//  Jasmine
//
//  Created by ebamboo on 2021/11/24.
//

import UIKit

///
/// 自由控制 UIButton 的 image 和 text 位置和间距
/// 只需要设置方向和距离即可
///
public class OrientationButton: UIButton {

    enum Orientation: Int {
        case landscapeLeft      = 0 ///  图片在左------作为默认值，效果等同于系统默认 UIButton
        case landscapeRight     = 1 ///  图片在右
        case portrait           = 2 ///  图片在上
        case upsideDown         = 3 ///  图片在下
    }

    @IBInspectable var orientation: Int = 0
    @IBInspectable var spacing: CGFloat = 0.0
    
}

public extension OrientationButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let tempOrientation = Orientation(rawValue: orientation) ?? .landscapeLeft
        switch tempOrientation {
        case .landscapeLeft:
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
        case .landscapeRight:
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
        case .portrait:
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
        case .upsideDown:
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
