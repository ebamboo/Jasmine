//
//  Autorelease.swift
//  Jasmine
//
//  Created by ebamboo on 2022/8/7.
//

import Foundation

// MARK: - ================ Timer ==================
// MARK: -

public extension Timer {
    
    func managed(by owner: NSObject) {
        owner.wrappedTimers.append(NSObject.WrappedTimer(self))
    }
    
}

private extension NSObject {
    
    static var wrapped_timers_key = "wrapped_timers_key"
    var wrappedTimers: [WrappedTimer] {
        get {
            objc_getAssociatedObject(self, &Self.wrapped_timers_key) as? [WrappedTimer] ?? []
        }
        set {
            objc_setAssociatedObject(self, &Self.wrapped_timers_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    class WrappedTimer {
        weak var timer: Timer?
        init(_ timer: Timer) { self.timer = timer }
        deinit { timer?.invalidate() }
    }
    
}

// MARK: - ============ NotificationCenter =============
// MARK: -

public extension NSObjectProtocol {
    
    func managed(by owner: NSObject) {
        owner.wrappedNotificationObservers.append(NSObject.WrappedNotificationObserver(self))
    }

}

private extension NSObject {
    
    static var wrapped_notification_observers_key = "wrapped_notification_observers_key"
    var wrappedNotificationObservers: [WrappedNotificationObserver] {
        get {
            objc_getAssociatedObject(self, &Self.wrapped_notification_observers_key) as? [WrappedNotificationObserver] ?? []
        }
        set {
            objc_setAssociatedObject(self, &Self.wrapped_notification_observers_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    class WrappedNotificationObserver {
        weak var observer: NSObjectProtocol?
        init(_ observer: NSObjectProtocol) { self.observer = observer }
        deinit {
            if let observer = observer {
                NotificationCenter.default.removeObserver(observer)
            }
        }
    }
    
}

// MARK: - ================= KVO ===================
// MARK: -

public extension NSKeyValueObservation {
    
    func managed(by owner: NSObject) {
        owner.keyValueObservations.append(self)
    }
    
}

private extension NSObject {

    static var key_value_observations_key = "key_value_observations_key"
    var keyValueObservations: [NSKeyValueObservation] {
        get {
            objc_getAssociatedObject(self, &Self.key_value_observations_key) as? [NSKeyValueObservation] ?? []
        }
        set {
            objc_setAssociatedObject(self, &Self.key_value_observations_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
