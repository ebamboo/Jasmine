//
//  UIGestureRecognizer+Handler.swift
//  SwiftTest01
//
//  Created by ebamboo on 2022/4/13.
//

import UIKit

public extension UIGestureRecognizer {
    
    /// 以 handler 初始化
    convenience init(action handler: @escaping (UIGestureRecognizer) -> Void) {
        let target = ActionHandlerTarget(handler: handler)
        self.init(target: target, action: #selector(ActionHandlerTarget.invoke(_:)))
        actionHandlerTargets.append(target)
    }
    
    /// 添加 handler
    func addActionHandler(_ handler: @escaping (UIGestureRecognizer) -> Void) {
        let target = ActionHandlerTarget(handler: handler)
        addTarget(target, action: #selector(ActionHandlerTarget.invoke(_:)))
        actionHandlerTargets.append(target)
    }
    
    /// 移除所有 handler
    func removeAllActionHandlers() {
        actionHandlerTargets.forEach { target in
            removeTarget(target, action: #selector(ActionHandlerTarget.invoke(_:)))
        }
        actionHandlerTargets.removeAll()
    }
    
}

private extension UIGestureRecognizer {
    
    class ActionHandlerTarget {
        var handler: (UIGestureRecognizer) -> Void
        init(handler: @escaping (UIGestureRecognizer) -> Void) {
            self.handler = handler
        }
        @objc func invoke(_ sender: UIGestureRecognizer) {
            handler(sender)
        }
    }
    
    static var action_handler_targets_key = "action_handler_targets_key"
    var actionHandlerTargets: [ActionHandlerTarget] {
        get {
            objc_getAssociatedObject(self, &Self.action_handler_targets_key) as? [ActionHandlerTarget] ?? []
        }
        set {
            objc_setAssociatedObject(self, &Self.action_handler_targets_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
