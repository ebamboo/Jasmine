//
//  FileManager+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/24.
//

import UIKit

public extension FileManager {
    
    ///
    /// 1. 全部磁盘容量
    /// 2. 可用磁盘容量
    /// 单位：字节 B
    ///
    var systemSize: CGFloat? {
        let attributes = try? attributesOfFileSystem(forPath: NSHomeDirectory())
        return attributes?[.systemSize] as? CGFloat
    }
    var systemFreeSize: CGFloat? {
        let attributes = try? attributesOfFileSystem(forPath: NSHomeDirectory())
        return attributes?[.systemFreeSize] as? CGFloat
    }
    
    ///
    /// 1. 文件大小
    /// 2. 文件夹大小
    /// 单位：字节 B
    ///
    func fileSize(filePath: String) -> UInt? {
        let attributes = try? attributesOfItem(atPath: filePath)
        return attributes?[.size] as? UInt
    }
    func folderSize(folderPath: String) -> UInt? {
        guard let subpaths = try? subpathsOfDirectory(atPath: folderPath) else { return nil }
        return subpaths.reduce(into: 0) { $0 += fileSize(filePath: $1) ?? 0 }
    }
    
}
