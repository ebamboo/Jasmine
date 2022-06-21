//
//  UITableViewCell+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/25.
//

import UIKit

public extension UITableViewCell {
    
    var tableView: UITableView? {
        var tempSuperview = superview
        while tempSuperview != nil {
            if tempSuperview!.isKind(of: UITableView.self) {
                return tempSuperview as? UITableView
            }
            tempSuperview = tempSuperview?.superview
        }
        return nil
    }
    
}
