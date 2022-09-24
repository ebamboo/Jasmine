//
//  CollectionViewTagLayout.swift
//  Jasmine
//
//  Created by ebamboo on 2022/9/24.
//

import UIKit

public extension CollectionViewTagLayout {
    
    var lineSpacing: CGFloat {
        get {
            _lineSpacing
        }
        set {
            _lineSpacing = newValue
        }
    }
    var interitemSpacing: CGFloat {
        get {
            _interitemSpacing
        }
        set {
            _interitemSpacing = newValue
        }
    }
    var itemHeight: CGFloat {
        get {
            _itemHeight
        }
        set {
            _itemHeight = newValue
        }
    }
    func itemWidthReader(_ reader: @escaping (_ collectionView: UICollectionView, _ indexPath: IndexPath) -> CGFloat) {
        _itemWidthReader = reader
    }
    
}

public class CollectionViewTagLayout: UICollectionViewLayout {

    private var _lineSpacing = 10.0
    private var _interitemSpacing = 10.0
    private var _itemHeight = 20.0
    private var _itemWidthReader = { (collectionView: UICollectionView, indexPath: IndexPath) -> CGFloat in 60.0 }

    private var _contentHeight = 0.0
    private var _layoutAttributesForItems = [UICollectionViewLayoutAttributes]()
        
}

public extension CollectionViewTagLayout {
    
    override func prepare() {
        super.prepare()
        
        // 清空记录数据
        _contentHeight = 0.0
        _layoutAttributesForItems = []
        
        // 空
        guard let numberOfItems = collectionView?.numberOfItems(inSection: 0), numberOfItems > 0 else { return }
        // 首项
        let firstIndexPath = IndexPath(item: 0, section: 0)
        let firstAttributes = UICollectionViewLayoutAttributes(forCellWith: firstIndexPath)
        firstAttributes.frame = CGRect(x: 0, y: 0, width: _itemWidthReader(collectionView!, firstIndexPath), height: _itemHeight)
        _contentHeight = _itemHeight
        _layoutAttributesForItems.append(firstAttributes)
        // n + 1 项
        guard numberOfItems > 1 else { return }
        (1..<numberOfItems).forEach { i in
            let indexPath = IndexPath(item: i, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let lastAttributes = _layoutAttributesForItems[i-1]
            let itemWidth = _itemWidthReader(collectionView!, indexPath)
            if lastAttributes.frame.origin.x + lastAttributes.frame.size.width + _interitemSpacing + itemWidth <= collectionView!.bounds.size.width { // 本行尾部追加
                attributes.frame = CGRect(
                    x: lastAttributes.frame.origin.x + lastAttributes.frame.size.width + _interitemSpacing,
                    y: lastAttributes.frame.origin.y,
                    width: itemWidth,
                    height: _itemHeight
                )
                _layoutAttributesForItems.append(attributes)
            } else { // 新开辟一行追加
                attributes.frame = CGRect(
                    x: 0,
                    y: lastAttributes.frame.origin.y + lastAttributes.frame.size.height + _lineSpacing,
                    width: itemWidth,
                    height: _itemHeight
                )
                _contentHeight += (_lineSpacing + _itemHeight)
                _layoutAttributesForItems.append(attributes)
            }
        }
        
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView!.bounds.size.width, height: _contentHeight)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return newBounds.width != collectionView?.bounds.width
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return _layoutAttributesForItems.filter { rect.intersects($0.frame) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if indexPath.item >= _layoutAttributesForItems.count { return nil }
        return _layoutAttributesForItems[indexPath.item]
    }
    
}
