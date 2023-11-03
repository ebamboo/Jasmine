//
//  URL+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2023/4/14.
//

import Foundation

public extension URL {
    
    /// 参数中 key 为非空字符串，value 值可以为 ""
    var param: [String: String] {
        var dic: [String: String] = [:]
        query?.components(separatedBy: "&").forEach { item in
            let temp = item.components(separatedBy: "=")
            if temp.count == 2, !temp.first!.isEmpty {
                dic[temp.first!] = temp.last!
            }
        }
        return dic
    }
    
}
