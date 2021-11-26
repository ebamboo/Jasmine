//
//  Double+Tools.swift
//  SwiftDK
//
//  Created by ebamboo on 2021/4/24.
//

import Foundation

extension Double {
    
    /// 弧度转为角度
    var degree: Double {
        return Double.pi * self / 180
    }
    
    /// 角度转为弧度
    var radian: Double {
        return self * 180 / Double.pi
    }
    
}
