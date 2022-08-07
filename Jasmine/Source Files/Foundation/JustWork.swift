//
//  JustWork.swift
//  Jasmine
//
//  Created by ebamboo on 2022/8/7.
//

import Foundation

public struct OnceWork {
    
    /// 进程生命周期内的单次任务
    /// 以 label 为标志记录一个任务
    @discardableResult init(_ label: String, work: () -> Void) {
        if Self.labels.contains(label) { return }
        Self.labels.insert(label)
        work()
    }
    
    private static var labels: Set<String> = []
}

public extension NSObject {
    
    /// NSObject 生命周期内确定次数的任务
    func justWork(_ times: Int, work: () -> Void) {
        if workTimes == nil { workTimes = times }
        if workTimes! <= 0 { return }
        workTimes = workTimes! - 1
        work()
    }
    
    private static var work_times_key = "work_times_key"
    private var workTimes: Int? {
        get {
            objc_getAssociatedObject(self, &Self.work_times_key) as? Int
        }
        set {
            objc_setAssociatedObject(self, &Self.work_times_key, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
}
