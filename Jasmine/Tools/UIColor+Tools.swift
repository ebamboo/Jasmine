//
//  UIColor+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/24.
//

import UIKit

public extension UIColor {
    
    /// 使用十六进制的数字 hex 表示颜色
    /// HEX 和 RGB 关系如下：
    /// 0xDC143C
    /// DC 表示 R, 14 表示 G, 3C 表示 B
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex >> 16) & 0xFF) / 255.0
        let g = CGFloat((hex >> 08) & 0xFF) / 255.0
        let b = CGFloat((hex >> 00) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(red255: Int, green255: Int, blue255: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red255) / 255.0, green: CGFloat(green255) / 255.0, blue: CGFloat(blue255) / 255.0, alpha: alpha)
    }
    
    static var randomColor: UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1.0)
    }
    
}
