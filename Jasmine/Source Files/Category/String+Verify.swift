//
//  String+Verify.swift
//  Jasmine
//
//  Created by ebamboo on 2022/7/1.
//

import Foundation

public extension String {
    
    var isPhone: Bool {
        let mobilePhone = "^1[2-9][0-9]{9}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", mobilePhone)
        return predicate.evaluate(with: self)
    }
    
    var isID: Bool {
        // 一、正则判断
        let ID = "^[1-9][0-9]{9}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])[0-9]{3}[0-9X]$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", ID)
        if !predicate.evaluate(with: self) { return false }
        
        // 二、通过最后一位校验码验证
        // 前 17 位加权因子
        let factors = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
        // 前 17 位加权和
        var weightedSum = 0
        for i in 0...16 {
            let num = (String(self[index(startIndex, offsetBy: i)]) as NSString).intValue
            let factor = factors[i]
            weightedSum += Int(num) * factor;
        }
        // 根据余数计算验证码
        let mod = weightedSum % 11
        let checkCodes = ["1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"]
        let checkCode = checkCodes[mod]
        let lastCode = String(self[index(before: endIndex)])
        return checkCode == lastCode
    }
    
    var hasChinese: Bool {
        for i in 0..<count {
            let char = self[index(startIndex, offsetBy: i)]
            if "\u{4e00}" <= char, char <= "\u{9fa5}" {
                return true
            }
        }
        return false
    }
    
    var hasSpace: Bool {
        return firstIndex(of: " ") != nil
    }
    
    ///
    /// 通用地检查字符串是否符合正则式所表达的 "规则"
    /// 使用 Rules(rawValue: "自定义正则式") 或者 Rules.custom("自定义正则式") 来检查自定义的正则式
    ///
    /// "*" 表示 {0, } 表示，"+" 表示 {1, } 表示，"?" 表示 {0, 1}
    ///
    struct Rules {
        let rawValue: String
        
        static let chinese = Rules(rawValue: "^[\u{4e00}-\u{9fa5}]+$")
        static let number = Rules(rawValue: "^[0-9]+$")
        static let letter = Rules(rawValue: "^[a-zA-Z]+$")
        static let lower = Rules(rawValue: "^[a-z]+$")
        static let upper = Rules(rawValue: "^[A-Z]+$")
        static let letterAndNumber = Rules(rawValue: "^[a-zA-Z0-9]+$")
        static let lowerAndNumber = Rules(rawValue: "^[a-z0-9]+$")
        static let upperAndNumber = Rules(rawValue: "^[A-Z0-9]+$")
        
        static func custom(_ rawValue: String) -> Rules { Rules(rawValue: rawValue) }
    }
    func evaluate(_ rules: Rules) -> Bool {
        return NSPredicate(format: "SELF matches %@", rules.rawValue).evaluate(with: self)
    }
    
}
