//
//  NSObject+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/25.
//

import Foundation

public extension NSObject {
    
    /// 在 limit 秒内倒计时
    func countdown(with limit: Int, progress: @escaping ((_ remainder: Int) -> Void), completion: @escaping (() -> Void)) {
        guard limit > 0 else { return }
        var tempTime = limit
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now(), repeating: 1.0)
        timer.setEventHandler {
            if tempTime <= 0 {
                timer.cancel()
                DispatchQueue.main.async {
                    completion()
                }
            } else {
                DispatchQueue.main.async {
                    progress(tempTime)
                    tempTime -= 1
                }
                
            }
        }
        timer.resume()
    }
    
}
