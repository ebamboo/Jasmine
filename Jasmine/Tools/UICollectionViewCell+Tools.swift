//
//  UICollectionViewCell+Tools.swift
//  SwiftDK
//
//  Created by ebamboo on 2021/4/24.
//

import UIKit

extension UICollectionViewCell {
    
    var collectionView: UICollectionView? {
        var tempSuperview: UIView? = superview
        while tempSuperview != nil {
            if let nextResponder = tempSuperview?.next, nextResponder.isKind(of: UICollectionView.self) {
                return nextResponder as? UICollectionView
            }
            tempSuperview = tempSuperview?.superview
        }
        return nil
    }
    
    var indexPath: IndexPath? {
        return collectionView?.indexPath(for: self)
    }
    
}
