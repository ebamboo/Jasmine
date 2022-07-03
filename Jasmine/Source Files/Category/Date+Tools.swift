//
//  Date+Tools.swift
//  Jasmine
//
//  Created by ebamboo on 2021/4/24.
//

import Foundation

public extension Date {
    
    /// date  string 转为 Date
    init(dateString: String, dateFormat: String, timeZone: TimeZone = TimeZone.current) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = timeZone
        
        self = dateFormatter.date(from: dateString) ?? Date()
    }
    
    /// Date 转为 date string
    func dateString(with dateFormat: String, timeZone: TimeZone = .current, locale: Locale = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        
        return dateFormatter.string(from: self)
    }
    
    /// 指定当前日历的日期时间生成 Date
    init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        
        self = Calendar.current.date(from: dateComponents) ?? Date()
    }
    
    /// 获取 Date 对应的农历日期 (年, 月, 日)
    var chineseYearMonthDay: (year: String, month: String, day: String)? {
        let chineseYears = [
            "甲子", "乙丑", "丙寅", "丁卯", "戊辰", "己巳", "庚午", "辛未", "壬申", "癸酉",
            "甲戌", "乙亥", "丙子", "丁丑", "戊寅", "己卯", "庚辰", "辛己", "壬午", "癸未",
            "甲申", "乙酉", "丙戌", "丁亥", "戊子", "己丑", "庚寅", "辛卯", "壬辰", "癸巳",
            "甲午", "乙未", "丙申", "丁酉", "戊戌", "己亥", "庚子", "辛丑", "壬寅", "癸丑",
            "甲辰", "乙巳", "丙午", "丁未", "戊申", "己酉", "庚戌", "辛亥", "壬子", "癸丑",
            "甲寅", "乙卯", "丙辰", "丁巳", "戊午", "己未", "庚申", "辛酉", "壬戌", "癸亥"
        ];
        let chineseMonths = [
            "正月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "冬月", "腊月"
        ];
        let chineseDays = [
            "初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十",
            "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
            "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"
        ]
        let components = Calendar(identifier: .chinese).dateComponents([.year, .month, .day], from: self)
        guard let yearInt = components.year, let monthInt = components.month, let dayInt = components.day else { return nil }
        let year = chineseYears[yearInt-1]
        let month = chineseMonths[monthInt-1]
        let day = chineseDays[dayInt-1]
        return (year, month, day)
    }
    
}
