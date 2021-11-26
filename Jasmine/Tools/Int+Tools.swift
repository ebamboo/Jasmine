//
//  Int+Tools.swift
//  SwiftDK
//
//  Created by ebamboo on 2021/5/7.
//

import Foundation

extension Int {
    
    /// [0, num] 范围内随机数
    static func random(in num: UInt32) -> Int {
        return Int(arc4random() % (num + 1))
    }
    
    /// [num1, num2] 范围内随机数
    static func random(from num1: UInt32, to num2: UInt32) -> Int {
        let min = Swift.min(num1, num2)
        let max = Swift.max(num1, num2)
        return Int(min + arc4random() % (max - min + 1))
    }
    
}
