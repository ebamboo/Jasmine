//
//  WeakObjects.swift
//  Jasmine
//
//  Created by ebamboo on 2022/8/7.
//

import Foundation

public struct Weak {
    weak private (set) var value: AnyObject?
    init(_ value: AnyObject) { self.value = value }
}

public extension Array where Element == Weak {
    mutating func compact() { self = filter { $0.value != nil } }
}

public extension Dictionary where Value == Weak {
    mutating func compact() { self = filter { $0.value.value != nil } }
}
