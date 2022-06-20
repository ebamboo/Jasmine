//
//  NSObject+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/25.
//

import Foundation

public extension NSObject {
    
    /// 在 limit 秒内倒计时
    @discardableResult func countdown(with limit: Int, progress: @escaping (_ caller: NSObject?, _ remainder: Int) -> Void, completion: @escaping (_ caller: NSObject?) -> Void) -> DispatchSourceTimer? {
        guard limit > 0 else { return nil }
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
