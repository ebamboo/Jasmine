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
    
}
