//
//  String+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/22.
//

import UIKit

public extension String {

    var isPhone: Bool {
        let mobilePhone = "^1[2-9][0-9]{9}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", mobilePhone)
        return predicate.evaluate(with: self)
    }
    
    var isEmail: Bool {
        let email = "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", email)
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
    
    var isAccount: Bool {
        let num = "^[a-zA-Z0-9_]+$"
        let predicate = NSPredicate(format: "SELF matches %@", num)
        return predicate.evaluate(with: self)
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
    
}

public extension String {
    
    struct Predicate {
        let rawValue: String
        static let chinese = Predicate(rawValue: "^[\u{4e00}-\u{9fa5}]+$")
        static let number = Predicate(rawValue: "^[0-9]+$")
        static let letter = Predicate(rawValue: "^[a-zA-Z]+$")
        static let lower = Predicate(rawValue: "^[a-z]+$")
        static let upper = Predicate(rawValue: "^[A-Z]+$")
        static let letterAndNumber = Predicate(rawValue: "^[a-zA-Z0-9]+$")
        static let lowerAndNumber = Predicate(rawValue: "^[a-z0-9]+$")
        static let upperAndNumber = Predicate(rawValue: "^[A-Z0-9]+$")
    }
    
    func evaluate(_ predicate: Predicate) -> Bool {
        return NSPredicate(format: "SELF matches %@", predicate.rawValue).evaluate(with: self)
    }
    
}

public extension String {
    
    /// 下标方法获取子字符串，下标参数为闭区间。 调用如：string[2...5]
    subscript(range: ClosedRange<Int>) -> String {
        let fromIndex = index(startIndex, offsetBy: range.lowerBound)
        let toIndex = index(startIndex, offsetBy: range.upperBound)
        return String(self[fromIndex...toIndex])
    }
    
    func sub(from: Int) -> String? {
        guard 0 <= from, from < count else { return nil }
        let fromIndex = index(startIndex, offsetBy: from)
        return String(self[fromIndex...])
    }
    
    func sub(to: Int) -> String? {
        guard 0 <= to, to < count else { return nil }
        let toIndex = index(startIndex, offsetBy: to)
        return String(self[...toIndex])
    }
    
    func sub(from: Int, to: Int) -> String? {
        guard 0 <= from, from <= to, to < count else { return nil }
        let fromIndex = index(startIndex, offsetBy: from)
        let toIndex = index(startIndex, offsetBy: to)
        return String(self[fromIndex...toIndex])
    }
    
    func sub(from: Int, offset: Int) -> String? {
        guard offset >= 0, 0 <= from, from + offset < count else { return nil }
        let fromIndex = index(startIndex, offsetBy: from)
        let toIndex = index(fromIndex, offsetBy: offset)
        return String(self[fromIndex...toIndex])
    }
    
    /// 获取拼音
    var pinyin: String? {
        var temp = self
        temp = temp.applyingTransform(.mandarinToLatin, reverse: false) ?? ""
        temp = temp.applyingTransform(.stripDiacritics, reverse: false) ?? ""
        temp = temp.replacingOccurrences(of: " ", with: "")
        return temp.isEmpty ? nil : temp
    }
    
    /// 把字符串转为 query of URL
    /// 形如： "id=35&name=小明&address=杭州滨江海兴雅苑"  的字符串可用
    var queryable: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    /// 去除字符串开头和结尾的可能的空格
    var core: String {
        return trimmingCharacters(in: .whitespaces)
    }
    
}

public extension String {
    
    /// 给定 font 和 width 计算出字符串所占用尺寸的高度
    func height(font: UIFont, width: CGFloat) -> CGFloat {
        let text = (self + "\n") as NSString
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesLineFragmentOrigin
        let attributes = [NSAttributedString.Key.font: font]
        let rect = text.boundingRect(with: size, options: options, attributes: attributes, context: nil)
        return rect.size.height
    }
    
    /// 打电话
    func call() {
        if let url = URL(string: "telprompt://\(self)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}