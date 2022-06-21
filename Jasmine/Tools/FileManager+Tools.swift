//
//  FileManager+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/24.
//

import UIKit

public extension FileManager {
    
    ///
    /// 全部磁盘容量
    ///
    var systemSize: CGFloat? {
        let attributes = try? attributesOfFileSystem(forPath: NSHomeDirectory())
        return attributes?[.systemSize] as? CGFloat
    }
    var systemSizeMB: CGFloat? {
        guard let size = systemSize else { return nil }
        return size / 1024 / 1024
    }
    
    ///
    /// 可用磁盘容量
    ///
    var systemFreeSize: CGFloat? {
        let attributes = try? attributesOfFileSystem(forPath: NSHomeDirectory())
        return attributes?[.systemFreeSize] as? CGFloat
    }
    var systemFreeSizeMB: CGFloat? {
        guard let size = systemFreeSize else { return nil }
        return size / 1024 / 1024
    }
    
    ///
    /// 1. 文件大小
    /// 2. 文件夹大小
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
