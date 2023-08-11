//
//  UIStackView+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2023/8/11.
//

import UIKit

public extension UIStackView {
    
    func removeAllArrangedSubviews () {
        let itemViewList = arrangedSubviews
        itemViewList.forEach { itemView in
            removeArrangedSubview(itemView)
            itemView.removeFromSuperview()
        }
    }
    
}
