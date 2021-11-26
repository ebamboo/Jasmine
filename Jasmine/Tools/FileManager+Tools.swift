//
//  FileManager+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/24.
//

import UIKit

extension FileManager {
    
    /// 全部可用磁盘
    var diskAllSize: CGFloat? {
        let attributes = try? attributesOfFileSystem(forPath: NSHomeDirectory())
        return attributes?[.systemSize] as? CGFloat
    }
    var diskAllSizeMB: CGFloat? {
        guard let size = diskAllSize else { return nil }
        return size / 1024 / 1024
    }
    
    /// 空闲可用磁盘
    var diskFreeSize: CGFloat? {
        let attributes = try? attributesOfFileSystem(forPath: NSHomeDirectory())
        return attributes?[.systemFreeSize] as? CGFloat
    }
    var diskFreeSizeMB: CGFloat? {
        guard let size = diskFreeSize else { return nil }
        return size / 1024 / 1024
    }
    
    func fileSize(filePath: String) -> UInt? {
        let attributes = try? attributesOfItem(atPath: filePath)
        return attributes?[.size] as? UInt
    }
    
    func folderSize(folderPath: String) -> UInt? {
        guard let subpaths = try? subpathsOfDirectory(atPath: folderPath) else { return nil }
        return subpaths.reduce(into: 0) { $0 += fileSize(filePath: $1) ?? 0 }
    }
    
}
