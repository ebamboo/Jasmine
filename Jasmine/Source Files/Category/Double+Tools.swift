//
//  Double+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/24.
//

import Foundation

public extension Double {
    
    ///
    /// 时间戳转 Date
    ///
    var dateSince1970: Date {
        return Date(timeIntervalSince1970: self)
    }
    var dateSinceNow: Date {
        return Date(timeIntervalSinceNow: self)
    }
    
    ///
    /// 1. 弧度转为角度
    /// 2. 角度转为弧度
    ///
    var degree: Double {
        return self * 180 / Double.pi
    }
    var radian: Double {
        return Double.pi * self / 180
    }
    
    ///
    /// 1. 向上取整
    /// 2. 向下取整
    /// 3. 四舍五入取整
    ///
    var ceil: Int {
        return Int(Darwin.ceil(self))
    }
    var floor: Int {
        return Int(Darwin.floor(self))
    }
    var round: Int {
        return Int(Darwin.round(self))
    }
    
}
