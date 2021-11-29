//
//  UITableView+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/11/29.
//

import UIKit

///        ！！！注意 ！！！
/// 如果展示的信息动态变化则不应该缓存高度
public extension UITableView {
    
    ///
    /// NSCache 缓存 cell 高度信息
    ///
    private static var cell_heights_info = "cell_heights_info"
    private var cellHeightsInfo: NSCache<NSIndexPath, NSNumber> {
        var info = objc_getAssociatedObject(self, &UITableView.cell_heights_info) as? NSCache<NSIndexPath, NSNumber>
        if info == nil {
            info = NSCache<NSIndexPath, NSNumber>()
            info?.countLimit = 99
            objc_setAssociatedObject(self, &UITableView.cell_heights_info, info, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return info!
    }

    /// 读取 cell 高度
    /// 一般在 heightForRow 从缓存读取高度
    func readCellHeight(for indexPath: IndexPath) -> CGFloat? {
        let height = cellHeightsInfo.object(forKey: indexPath as NSIndexPath)
        if height == nil {
            return nil
        } else {
            return height!.doubleValue
        }
    }

    /// 存储 cell 高度
    /// 一般在 willDisplay 获取 cell 高度进行缓存
    func writeCellHeight(_ height: CGFloat, for indexPath: IndexPath) {
        cellHeightsInfo.setObject(NSNumber(value: height), forKey: indexPath as NSIndexPath)
    }
    
}
