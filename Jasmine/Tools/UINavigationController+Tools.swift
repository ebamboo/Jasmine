//
//  UINavigationController+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/25.
//

import UIKit

public extension UINavigationController {
    
    func pushViewController(_ viewController: UIViewController, hidesBottomBar: Bool, hidesBackButton: Bool, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = hidesBottomBar
        viewController.navigationItem.hidesBackButton = hidesBackButton
        pushViewController(viewController, animated: animated)
    }
    
}
