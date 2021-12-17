//
//  CollectionViewFlowLayout.swift
//  Jasmine
//
//  Created by ebamboo on 2021/12/17.
//

import UIKit

public class CollectionViewFlowLayout: UICollectionViewFlowLayout {

    ///
    /// item size 获取方法作为一个属性
    /// 可以实现动态获取 item size
    ///
    
    private var itemSizeReader: ((UICollectionView?) -> CGSize)?
    func itemSizeReader(_ reader: @escaping (_ collectionView: UICollectionView?) -> CGSize) {
        itemSizeReader = reader
    }
    
    public override func prepare() {
        super.prepare()
        if itemSizeReader != nil {
            itemSize = itemSizeReader!(collectionView)
        }
    }
    
}
