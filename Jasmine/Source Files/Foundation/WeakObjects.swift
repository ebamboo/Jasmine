//
//  WeakObjects.swift
//  Jasmine
//
//  Created by ebamboo on 2022/8/7.
//

import Foundation

struct Weak {
    weak private (set) var value: AnyObject?
    init(_ value: AnyObject) { self.value = value }
}

extension Array where Element == Weak {
    mutating func compact() { self = filter { $0.value != nil } }
}

extension Dictionary where Value == Weak {
    mutating func compact() { self = filter { $0.value.value != nil } }
}
