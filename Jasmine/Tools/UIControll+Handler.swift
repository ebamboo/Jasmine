//
//  UIControll+Handler.swift
//  SwiftTest01
//
//  Created by ebamboo on 2022/4/13.
//

import UIKit

public extension UIControl {
    
    /// 添加 action Handler 响应事件
    func addActionHandler(for events: Event, _ handler: @escaping (UIControl) -> Void) {
        let target = ActionHandlerTarget(events: events, handler: handler)
        addTarget(target, action: #selector(ActionHandlerTarget.invoke(_:)), for: target.events)
        actionHandlerTargets.append(target)
    }
    
    /// 移除特定 events 及对应的 action handler 响应事件
    func removeAllActionHandlers(for events: Event = .allEvents) {
        actionHandlerTargets.removeAll { target in
            let newEvents = target.events.subtracting(events) // 返回 target.events 减去 events 的结果
            if newEvents.isEmpty {
                return true
            } else {
                removeTarget(target, action: #selector(ActionHandlerTarget.invoke(_:)), for: target.events)
                target.events = newEvents
                addTarget(target, action: #selector(ActionHandlerTarget.invoke(_:)), for: target.events)
                return false
            }
        }
    }
    
}

private extension UIControl {
    
    class ActionHandlerTarget {
        var events: Event
        var handler: (UIControl) -> Void
        init(events: Event, handler: @escaping (UIControl) -> Void) {
            self.events = events
            self.handler = handler
        }
        @objc func invoke(_ sender: UIControl) {
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
