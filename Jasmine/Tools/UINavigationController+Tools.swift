//
//  UINavigationController+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/25.
//

import UIKit

extension UINavigationController {
    
    func pushViewController(_ viewController: UIViewController, hideBottomBar: Bool, hideBackItem: Bool, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = hideBottomBar
        viewController.navigationItem.hidesBackButton = hideBackItem
        pushViewController(viewController, animated: animated)
    }
    
}
