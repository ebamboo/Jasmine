//
//  UITableViewCell+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/25.
//

import UIKit

public extension UITableViewCell {
    
    var tableView: UITableView? {
        var tempSuperview: UIView? = superview
        while tempSuperview != nil {
            if let nextResponder = tempSuperview?.next, nextResponder.isKind(of: UITableView.self) {
                return nextResponder as? UITableView
            }
            tempSuperview = tempSuperview?.superview
        }
        return nil
    }
    
    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }
    
}
