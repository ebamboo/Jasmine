//
//  Double+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/24.
//

import Foundation

public extension Double {
    
    /// 弧度转为角度
    var degree: Double {
        return self * 180 / Double.pi
    }
    
    /// 角度转为弧度
    var radian: Double {
        return Double.pi * self / 180
    }
    
    ///
    /// 转 Int
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
