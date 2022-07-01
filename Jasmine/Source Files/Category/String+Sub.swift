//
//  String+Sub.swift
//  Jasmine
//
//  Created by ebamboo on 2022/7/1.
//

import Foundation

public extension String {
    
    /// 下标方法获取指定 range 子字符串
    /// 下标参数为闭区间。 调用如："0123456"[2...5] 结果为 "2345"
    subscript(range: ClosedRange<Int>) -> String? {
        guard 0 <= range.lowerBound, range.upperBound < count else { return nil }
        let fromIndex = index(startIndex, offsetBy: range.lowerBound)
        let toIndex = index(startIndex, offsetBy: range.upperBound)
        return String(self[fromIndex...toIndex])
    }
    
    /// 下标方法获取指定 index 字符
    /// 若存在则返回仅包含单个字符的字符串。调用如："0123456"[3] 结果为 "3"
    subscript(index: Int) -> String? {
        return self[index...index]
    }
    
    /// 从 fromIndex 开始，包括 fromIndex
    func sub(from: Int) -> String? {
        guard 0 <= from, from < count else { return nil }
        let fromIndex = index(startIndex, offsetBy: from)
        return String(self[fromIndex...])
    }
    
    /// 取到 toIndex，包括 toIndex
    func sub(to: Int) -> String? {
        guard 0 <= to, to < count else { return nil }
        let toIndex = index(startIndex, offsetBy: to)
        return String(self[...toIndex])
    }
    
    /// 从 fromIndex 开始取到 toIndex，包括 fromIndex 和 toIndex
    func sub(from: Int, to: Int) -> String? {
        guard 0 <= from, from <= to, to < count else { return nil }
        let fromIndex = index(startIndex, offsetBy: from)
        let toIndex = index(startIndex, offsetBy: to)
        return String(self[fromIndex...toIndex])
    }
    
    /// offset 表示 toIndex 相对于 fromIndex 偏移量
    /// "0123456".sub(from: 0, offset: 0) 返回 "0"
    /// "0123456".sub(from: 2, offset: 2) 返回 "234"
    func sub(from: Int, offset: Int) -> String? {
        guard offset >= 0, 0 <= from, from + offset < count else { return nil }
        let fromIndex = index(startIndex, offsetBy: from)
        let toIndex = index(fromIndex, offsetBy: offset)
        return String(self[fromIndex...toIndex])
    }
    
}
