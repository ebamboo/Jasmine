//
//  JustWork.swift
//  Jasmine
//
//  Created by ebamboo on 2022/8/7.
//

import Foundation

public struct JustWork {
    
    /// 标记为 label 的任务在 App 进程生命周期内最多执行 times 次数
    @discardableResult init(_ times: Int = 1, label: String = "", work: () -> Void) {
        if !Self.workTimesInfo.contains(where: { (key: String, value: Int) in key == label }) { Self.workTimesInfo[label] = times }
        if Self.workTimesInfo[label]! <= 0 { return }
        Self.workTimesInfo[label] = Self.workTimesInfo[label]! - 1
        work()
    }
    
    private static var workTimesInfo: [String: Int] = [:]
    
}

public extension NSObject {
    
    /// 标记为 label 的任务在 NSObject 生命周期内最多执行 times 次数
    func justWork(_ times: Int = 1, label: String = "", work: () -> Void) {
        if !workTimesInfo.contains(where: { (key: String, value: Int) in key == label }) { workTimesInfo[label] = times }
        if workTimesInfo[label]! <= 0 { return }
        workTimesInfo[label] = workTimesInfo[label]! - 1
        work()
    }
    
    private static var work_times_info_key = "work_times_info_key"
    private var workTimesInfo: [String: Int] {
        get {
            objc_getAssociatedObject(self, &Self.work_times_info_key) as? [String: Int] ?? [:]
        }
        set {
            objc_setAssociatedObject(self, &Self.work_times_info_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
