//
//  UITableView+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/11/29.
//

import UIKit

///
/// 部分刷新快捷方法
///
public extension UITableView {
    
    /// 快捷刷新 rows
    func reloadRows(_ rows: Int..., in section: Int = 0, with animation: UITableView.RowAnimation = .none) {
        let indexPaths = rows.map { row in
            IndexPath(row: row, section: section)
        }
        reloadRows(at: indexPaths, with: animation)
    }
    
    /// 快捷刷新 sections
    func reloadSections(_ sections: Int..., with animation: UITableView.RowAnimation = .none) {
        reloadSections(IndexSet(sections), with: animation)
    }
    
}

///
/// 使用 NSCache 缓存 UITableViewCell 高度
///
/// 注意 ：如果展示的信息动态变化则不应该缓存高度
///
public extension UITableView {
    
    /// 读取 cell 高度
    /// 一般在 heightForRow 从缓存读取高度
    func readCellHeight(for indexPath: IndexPath) -> CGFloat? {
        guard let height = cellHeightsInfo.object(forKey: indexPath as NSIndexPath) else { return nil }
        return height.doubleValue
    }

    /// 存储 cell 高度
    /// 一般在 willDisplay 获取 cell 高度进行缓存
    func writeCellHeight(_ height: CGFloat, for indexPath: IndexPath) {
        cellHeightsInfo.setObject(NSNumber(value: height), forKey: indexPath as NSIndexPath)
    }
    
}

private extension UITableView {
    
    static var cell_heights_info_key = "cell_heights_info_key"
    var cellHeightsInfo: NSCache<NSIndexPath, NSNumber> {
        var info = objc_getAssociatedObject(self, &UITableView.cell_heights_info_key) as? NSCache<NSIndexPath, NSNumber>
        if info == nil {
            info = NSCache<NSIndexPath, NSNumber>()
            info?.countLimit = 99
            objc_setAssociatedObject(self, &UITableView.cell_heights_info_key, info, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return info!
    }
    
}
