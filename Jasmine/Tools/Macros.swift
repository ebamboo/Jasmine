//
//  Macros.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/21.
//

import UIKit

/// 设备当前系统版本
public let SystemVersion = UIDevice.current.systemVersion
/// App 版本
public let AppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
/// 当前语言
public let CurrentLanguage = Locale.preferredLanguages.first

/// 沙盒根路径
public let HomePath = NSHomeDirectory()
/// Documents 路径
public let DocumentsPath = HomePath + "/Documents"
/// Library/Caches 设备缓存路径
public let CachesPath = HomePath + "/Library/Caches"

public var ScreenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}
public var ScreenHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}
public var ScreenSize: CGSize {
    return UIScreen.main.bounds.size
}
public var DeviceWidth: CGFloat {
    min(ScreenSize.width, ScreenSize.height)
}
public var DeviceHeight: CGFloat {
    max(ScreenSize.width, ScreenSize.height)
}

/// 判断是否竖屏展示内容
public var Portrait: Bool {
    return ScreenSize.width < ScreenSize.height
}
/// 判断是否横屏展示内容
public var Landscape: Bool {
    return ScreenSize.width > ScreenSize.height
}
