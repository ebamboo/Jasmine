//
//  UICollectionView+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2022/5/26.
//

import UIKit

///
/// 部分刷新快捷方法
///
public extension UICollectionView {
    
    /// 自定义快捷刷新 items
    func reloadItems(_ items: Int..., in section: Int = 0) {
        let indexPaths = items.map { item in
            IndexPath(item: item, section: section)
        }
        reloadItems(at: indexPaths)
    }
    
    /// 自定义快捷刷新 sections
    func reloadSections(_ sections: Int...) {
        reloadSections(IndexSet(sections))
    }
    
}
