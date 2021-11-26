//
//  Date+Tools.swift
//  SwiftDK
//
//  Created by ebamboo on 2021/4/24.
//

import Foundation

extension Date {

    func chineseYearMonthDay() -> (year: String, month: String, day: String)? {
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
        let chineseCalendar = Calendar(identifier: .chinese)
        let chineseComp = chineseCalendar.dateComponents([.year, .month, .day], from: self)
        guard let yearInt = chineseComp.year,
              let monthInt = chineseComp.month,
              let dayInt = chineseComp.day
        else {
            return nil
        }
        let year = chineseYears[yearInt-1]
        let month = chineseMonths[monthInt-1]
        let day = chineseDays[dayInt-1]
        return (year, month, day)
    }
    
}
