//
//  UIGestureRecognizer+Handler.swift
//  SwiftTest01
//
//  Created by ebamboo on 2022/4/13.
//

import UIKit

public extension UIGestureRecognizer {
    
    /// 以 action Handler 响应事件初始化
    convenience init(action handler: @escaping (UIGestureRecognizer) -> Void) {
        let target = ActionHandlerTarget(handler: handler)
        self.init(target: target, action: #selector(ActionHandlerTarget.invoke(_:)))
        actionHandlerTargets.append(target)
    }
    
    /// 添加 action Handler 响应事件
    func addActionHandler(_ handler: @escaping (UIGestureRecognizer) -> Void) {
        let target = ActionHandlerTarget(handler: handler)
        addTarget(target, action: #selector(ActionHandlerTarget.invoke(_:)))
        actionHandlerTargets.append(target)
    }
    
    /// 移除 action handler 响应事件
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
    
    static var ActionHandlerTargetsKey = "ActionHandlerTargetsKey"
    var actionHandlerTargets: [ActionHandlerTarget] {
        get {
            objc_getAssociatedObject(self, &Self.ActionHandlerTargetsKey) as? [ActionHandlerTarget] ?? []
        }
        set {
            objc_setAssociatedObject(self, &Self.ActionHandlerTargetsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
