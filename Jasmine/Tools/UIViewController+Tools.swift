//
//  UIViewController+Tools.swift
//  SwiftDK
//
//  Created by ebamboo on 2021/4/25.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String?, messgae: String?, ensureTitle: String, ensureAction: (() -> Void)? = nil) {
        let alertVC = UIAlertController.init(title: title, message: messgae, preferredStyle: .alert)
        let ensureBtn = UIAlertAction(title: ensureTitle, style: .default) { (_) in
            ensureAction?()
        }
        alertVC.addAction(ensureBtn)
        present(alertVC, animated: true, completion: nil)
    }
    
    func presentAlert(title: String?, messgae: String?, ensureTitle: String, ensureAction: @escaping (() -> Void), cancelTitle: String, cancelAction: @escaping (() -> Void)) {
        let alertVC = UIAlertController.init(title: title, message: messgae, preferredStyle: .alert)
        let ensureBtn = UIAlertAction(title: ensureTitle, style: .default) { (_) in
            ensureAction()
        }
        let cancelBtn = UIAlertAction(title: cancelTitle, style: .default) { (_) in
            cancelAction()
        }
        alertVC.addAction(ensureBtn)
        alertVC.addAction(cancelBtn)
        present(alertVC, animated: true, completion: nil)
    }
    
    func presentAlert(title: String?, messgae: String?, actions: [UIAlertAction]?) {
        let alertVC = UIAlertController.init(title: title, message: messgae, preferredStyle: .alert)
        if let actions = actions {
            for action in actions {
                alertVC.addAction(action)
            }
        }
        present(alertVC, animated: true, completion: nil)
    }
    
    func presentSheet(title: String?, messgae: String?, cancelTitle: String, cancelAction: @escaping (() -> Void), optionTitle: String, optionAction: @escaping (() -> Void)) {
        let sheetVC = UIAlertController(title: title, message: messgae, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: cancelTitle, style: .default) { (_) in
            cancelAction()
        }
        let optionBtn = UIAlertAction(title: optionTitle, style: .default) { (_) in
            optionAction()
        }
        sheetVC.addAction(cancelBtn)
        sheetVC.addAction(optionBtn)
        present(sheetVC, animated: true, completion: nil)
    }
    
    func presentSheet(title: String?, messgae: String?, actions: [UIAlertAction]?) {
        let sheetVC = UIAlertController(title: title, message: messgae, preferredStyle: .actionSheet)
        if let actions = actions {
            for action in actions {
                sheetVC.addAction(action)
            }
        }
        present(sheetVC, animated: true, completion: nil)
    }
    
}

extension UIViewController {
    
    func addChildViewController(_ child: UIViewController, in container: UIView, in rect: CGRect, completion: (() -> Void)?) {
        addChild(child)
        child.view.frame = rect
        container.addSubview(child.view)
        completion?()
    }
    
    func removeChildViewController(_ child: UIViewController, completion: (() -> Void)?) {
        child.view.removeFromSuperview()
        child.willMove(toParent: nil)
        child.removeFromParent()
        completion?()
    }
    
    func removeFromParentViewController(completion: (() -> Void)?) {
        view.removeFromSuperview()
        willMove(toParent: nil)
        removeFromParent()
        completion?()
    }
    
}
