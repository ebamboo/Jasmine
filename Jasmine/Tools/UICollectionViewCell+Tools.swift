//
//  UICollectionViewCell+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/24.
//

import UIKit

public extension UICollectionViewCell {
    
    var collectionView: UICollectionView? {
        var tempSuperview = superview
        while tempSuperview != nil {
            if tempSuperview!.isKind(of: UICollectionView.self) {
                return tempSuperview as? UICollectionView
            }
            tempSuperview = tempSuperview?.superview
        }
        return nil
    }
    
}
