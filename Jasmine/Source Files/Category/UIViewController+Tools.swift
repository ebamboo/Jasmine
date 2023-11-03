//
//  UIViewController+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/25.
//

import UIKit

public extension UIViewController {
    
    func presentAlert(title: String?, message: String?, actions: [UIAlertAction] = []) {
        let vc = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        for btn in actions { vc.addAction(btn) }
        present(vc, animated: true, completion: nil)
    }
    
    func presentSheet(title: String?, message: String?, actions: [UIAlertAction] = []) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for btn in actions { vc.addAction(btn) }
        present(vc, animated: true, completion: nil)
    }
    
    func presentAlert(
        title: String?,
        message: String?,
        actionsTitle: String...,
        actionsHandler: @escaping (_ index: Int, _ action: UIAlertAction) -> Void
    ) {
        let vc = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        for (index, actionTitle) in actionsTitle.enumerated() {
            let btn = UIAlertAction(title: actionTitle, style: .default) { action in
                actionsHandler(index, action)
            }
            vc.addAction(btn)
        }
        present(vc, animated: true, completion: nil)
    }
    
    func presentSheet(
        title: String?,
        message: String?,
        cancelTitle: String,
        cancelHandler: @escaping (_ action: UIAlertAction) -> Void,
        optionsTitle: String...,
        optionsHandler: @escaping (_ index: Int, _ action: UIAlertAction) -> Void
    ) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: cancelTitle, style: .cancel) { action in
            cancelHandler(action)
        }
        vc.addAction(cancelBtn)
        for (index, optionTitle) in optionsTitle.enumerated() {
            let optionBtn = UIAlertAction(title: optionTitle, style: .default) { action in
                optionsHandler(index, action)
            }
            vc.addAction(optionBtn)
        }
        present(vc, animated: true, completion: nil)
    }
    
}

public extension UIViewController {
    
    func addChild(_ child: UIViewController, in container: UIView, in rect: CGRect, completion: (() -> Void)?) {
        addChild(child)
        child.view.frame = rect
        container.addSubview(child.view)
        completion?()
    }
    
    func removeChild(_ child: UIViewController, completion: (() -> Void)?) {
        child.view.removeFromSuperview()
        child.willMove(toParent: nil)
        child.removeFromParent()
        completion?()
    }
    
    func removeSelf() {
        view.removeFromSuperview()
        willMove(toParent: nil)
        removeFromParent()
    }
    
}
