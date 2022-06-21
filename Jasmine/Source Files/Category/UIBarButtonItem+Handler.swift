//
//  UIBarButtonItem+Handler.swift
//  SwiftTest01
//
//  Created by ebamboo on 2022/4/13.
//

import UIKit

public extension UIBarButtonItem {
    
    convenience init(title: String?, style: UIBarButtonItem.Style, action handler: @escaping (UIBarButtonItem) -> Void) {
        let newTarget = ActionHandlerTarget(handler: handler)
        self.init(title: title, style: style, target: newTarget, action: #selector(ActionHandlerTarget.invoke(_:)))
        actionHandlerTarget = newTarget
    }
    
    convenience init(image: UIImage?, style: UIBarButtonItem.Style, action handler: @escaping (UIBarButtonItem) -> Void) {
        let newTarget = ActionHandlerTarget(handler: handler)
        self.init(image: image, style: style, target: newTarget, action: #selector(ActionHandlerTarget.invoke(_:)))
        actionHandlerTarget = newTarget
    }
    
    /// 设置或者重新设置响应事件
    func setActionHandler(_ handler: @escaping (UIBarButtonItem) -> Void) {
        let newTarget = ActionHandlerTarget(handler: handler)
        target = newTarget
        action = #selector(ActionHandlerTarget.invoke(_:))
        actionHandlerTarget = newTarget
    }
    
}

private extension UIBarButtonItem {
    
    class ActionHandlerTarget {
        var handler: (UIBarButtonItem) -> Void
        init(handler: @escaping (UIBarButtonItem) -> Void) {
            self.handler = handler
        }
        @objc func invoke(_ sender: UIBarButtonItem) {
            handler(sender)
        }
    }
    
    static var ActionHandlerTargetKey = "ActionHandlerTargetKey"
    var actionHandlerTarget: ActionHandlerTarget? {
        get {
            objc_getAssociatedObject(self, &Self.ActionHandlerTargetKey) as? ActionHandlerTarget
        }
        set {
            objc_setAssociatedObject(self, &Self.ActionHandlerTargetKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
