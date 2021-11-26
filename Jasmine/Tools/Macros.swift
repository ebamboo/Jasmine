//
//  Macros.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/21.
//

import UIKit

/// 设备当前系统版本
let SystemVersion = UIDevice.current.systemVersion
/// App 版本
let AppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
/// UUID
let UUID = UIDevice.current.identifierForVendor?.uuidString
/// 当前语言
let CurrentLanguage = Locale.preferredLanguages.first

/// 沙盒根路径
let HomePath = NSHomeDirectory()
/// Documents 路径
let DocumentsPath = HomePath + "/Documents"
/// Library/Caches 设备缓存路径
let CachesPath = HomePath + "/Library/Caches"

var ScreenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}
var ScreenHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}
var ScreenSize: CGSize {
    return UIScreen.main.bounds.size
}
var DeviceWidth: CGFloat {
    min(ScreenSize.width, ScreenSize.height)
}
var DeviceHeight: CGFloat {
    max(ScreenSize.width, ScreenSize.height)
}

/// 判断是否竖屏展示内容
var Portrait: Bool {
    return ScreenSize.width < ScreenSize.height
}
/// 判断是否横屏展示内容
var Landscape: Bool {
    return ScreenSize.width > ScreenSize.height
}
