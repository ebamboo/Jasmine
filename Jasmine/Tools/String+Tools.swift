//
//  String+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/22.
//

import UIKit

// MARK: - 校验

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
    
    var onlyHasNumber: Bool {
        let num = "^[0-9]+$"
        let predicate = NSPredicate(format: "SELF matches %@", num)
        return predicate.evaluate(with: self)
    }
    
    var onlyHasLetter: Bool {
        let letter = "^[a-zA-Z]+$"
        let predicate = NSPredicate(format: "SELF matches %@", letter)
        return predicate.evaluate(with: self)
    }
    
    var onlyHasUpperLetter: Bool {
        let upperLetter = "^[A-Z]+$"
        let predicate = NSPredicate(format: "SELF matches %@", upperLetter)
        return predicate.evaluate(with: self)
    }
    
    var onlyHasLowerLetter: Bool {
        let lowerLetter = "^[a-z]+$"
        let predicate = NSPredicate(format: "SELF matches %@", lowerLetter)
        return predicate.evaluate(with: self)
    }
    
    var onlyHasLetterAndNumber: Bool {
        let letterAndNumber = "^[a-zA-Z0-9]+$"
        let predicate = NSPredicate(format: "SELF matches %@", letterAndNumber)
        return predicate.evaluate(with: self)
    }
    
    var onlyHasUpperLetterAndNumber: Bool {
        let upperLetterAndNumber = "^[A-Z0-9]+$"
        let predicate = NSPredicate(format: "SELF matches %@", upperLetterAndNumber)
        return predicate.evaluate(with: self)
    }
    
    var onlyHasLowerLetterAndNumber: Bool {
        let lowerLetterAndNumber = "^[a-z0-9]+$"
        let predicate = NSPredicate(format: "SELF matches %@", lowerLetterAndNumber)
        return predicate.evaluate(with: self)
    }
    
    var onlyHasChinese: Bool {
        let chinese = "^[\u{4e00}-\u{9fa5}]+$"
        let predicate = NSPredicate(format: "SELF matches %@", chinese)
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

// MARK: - 子字符串

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
    
    /// URL 编码字符串
    var url: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    /// 去除字符串开头和结尾的可能的空格
    var core: String {
        return trimmingCharacters(in: .whitespaces)
    }
    
}

// MARK: - 功能

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
    func callPhone() {
        if let url = URL(string: "telprompt://\(self)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
