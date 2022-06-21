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
    
    /// 使用 [0~255] 范围的 RGB 初始化颜色
    convenience init(r255: Int, g255: Int, b255: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat(r255) / 255.0
        let g = CGFloat(g255) / 255.0
        let b = CGFloat(b255) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    /// 获取一个随机颜色
    static var random: UIColor {
        let r = CGFloat(arc4random_uniform(256)) / 255.0
        let g = CGFloat(arc4random_uniform(256)) / 255.0
        let b = CGFloat(arc4random_uniform(256)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
}
