//
//  UIViewController+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/25.
//

import UIKit

public extension UIViewController {
    
    func presentAlert(title: String?, messgae: String?, ensureTitle: String, ensureAction: (() -> Void)? = nil) {
        let vc = UIAlertController(title: title, message: messgae, preferredStyle: .alert)
        let ensureBtn = UIAlertAction(title: ensureTitle, style: .default) { _ in
            ensureAction?()
        }
        vc.addAction(ensureBtn)
        present(vc, animated: true, completion: nil)
    }
    
    func presentAlert(title: String?, messgae: String?, leftTitle: String, leftAction: @escaping (() -> Void), rightTitle: String, rightAction: @escaping (() -> Void)) {
        let vc = UIAlertController.init(title: title, message: messgae, preferredStyle: .alert)
        let leftBtn = UIAlertAction(title: leftTitle, style: .default) { _ in
            leftAction()
        }
        let rightBtn = UIAlertAction(title: rightTitle, style: .default) { _ in
            rightAction()
        }
        vc.addAction(leftBtn)
        vc.addAction(rightBtn)
        present(vc, animated: true, completion: nil)
    }
    
    func presentAlert(title: String?, messgae: String?, actions: [UIAlertAction]?) {
        let vc = UIAlertController.init(title: title, message: messgae, preferredStyle: .alert)
        if let actions = actions {
            for action in actions {
                vc.addAction(action)
            }
        }
        present(vc, animated: true, completion: nil)
    }
    
    func presentSheet(title: String?, messgae: String?, cancelTitle: String, cancelAction: @escaping (() -> Void), optionTitle: String, optionAction: @escaping (() -> Void)) {
        let vc = UIAlertController(title: title, message: messgae, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
            cancelAction()
        }
        let optionBtn = UIAlertAction(title: optionTitle, style: .default) { _ in
            optionAction()
        }
        vc.addAction(cancelBtn)
        vc.addAction(optionBtn)
        present(vc, animated: true, completion: nil)
    }
    
    func presentSheet(title: String?, messgae: String?, actions: [UIAlertAction]?) {
        let vc = UIAlertController(title: title, message: messgae, preferredStyle: .actionSheet)
        if let actions = actions {
            for action in actions {
                vc.addAction(action)
            }
        }
        present(vc, animated: true, completion: nil)
    }
    
}

public extension UIViewController {
    
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
