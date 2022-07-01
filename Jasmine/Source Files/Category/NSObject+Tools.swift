//
//  NSObject+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/25.
//

import Foundation

public extension NSObject {
    
    /// 倒计时功能
    /// 在 limit 秒内，每隔 1 秒调用一次 progress，结束后调用 completion
    ///
    /// 注意：
    /// progress 和 completion 在主线程中执行
    /// 引用返回的 DispatchSourceTimer 时，最好使用弱引用，这样系统会自动管理 timer 内存
    @discardableResult func countdown(with limit: Int, progress: @escaping (_ caller: NSObject?, _ remainder: Int) -> Void, completion: @escaping (_ caller: NSObject?) -> Void) -> DispatchSourceTimer {
        weak var weakself = self
        var tempTime = limit
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now(), repeating: 1.0)
        timer.setEventHandler {
            if tempTime <= 0 {
                timer.cancel()
                DispatchQueue.main.async {
                    completion(weakself)
                }
            } else {
                DispatchQueue.main.async {
                    progress(weakself, tempTime)
                    tempTime -= 1
                }
            }
        }
        timer.resume()
        return timer
    }
    
}
