//
//  Date+Tool.swift
//  YuanJuBian
//
//  Created by mac on 2022/1/13.
//

import Foundation

extension TimeInterval{
    
    /// 将时间戳换算为多少天
    func toDay() -> Int{
        
        return Int(self / 60 / 60 / 24)
    }
}

extension Date{
    
    /// 获取当前的时间戳
    /// - Returns: ~
    static func currentDayTimeInterval() -> TimeInterval{
        
        return Date().timeIntervalSince1970
    }
    
    /// 计算两个时间戳之间的差
    /// - Parameters:
    ///   - dateTimeInterval: ～
    ///   - anotherDateTimeInterval: ～
    /// - Returns: ～
    static func timeIntervalBetween(_ dateTimeInterval:TimeInterval,and anotherDateTimeInterval:TimeInterval) -> TimeInterval{
        return abs(dateTimeInterval - anotherDateTimeInterval)
    }
    
    /// 将小时转为时间
    /// - Parameter hour: 小时
    /// - Returns: 日期
    static func makeDate(with hour:Int) -> Date?{
        
        let timeString = "\(hour):00:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.date(from: timeString)
    }
    
    /// 获取年
    /// - Returns: 年
    static func getCurrentYear(_ date:Date = Date()) -> Int{
        
        return Calendar.current.component(.year, from: date)
    }
    
    /// 获取月
    /// - Parameter date: 日期
    /// - Returns: 月
    static func getCurrentMonth(_ date:Date = Date()) -> Int{
        
        return Calendar.current.component(.month, from: date)
    }
    
    /// 获取天
    /// - Parameter date: 日期
    /// - Returns: 天
    static func getCurrentDay(_ date:Date = Date()) -> Int{
        
        return Calendar.current.component(.day, from: date)
    }
    
    /// 获取小时
    /// - Returns: 小时
    static func getCurrentHour(_ date:Date = Date()) -> Int{
        
        return Calendar.current.component(.hour, from: date)
    }
    
    /// 获取时间戳
    /// - Returns: ~
    static func getTimesstamp(_ date:Date = Date()) -> TimeInterval{
        
        return date.timeIntervalSince1970
    }
    
    /// 某年的第一个时间
    /// - Parameter year: 某年
    /// - Returns: 第一天的时间
    static func firstDayTimeOfYear(_ year:Int) -> Date{
        
        let dayTimeStr = "\(year).01.01 00:00:00"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM.dd HH:mm:ss"
        return formatter.date(from: dayTimeStr)!
    }
    
    /// 某年的最后一天
    /// - Parameter year: 某年
    /// - Returns: 最后时间
    static func lastDayTimeOfYear(_ year:Int) -> Date{
        
        let dayTimeStr = "\(year).12.31 23:59:59"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM.dd HH:mm:ss"
        return formatter.date(from: dayTimeStr)!
    }
    /// 获取日期在星期几，0-6依次为日一二三四五六
    /// - Parameter date: 日期
    /// - Returns: 星期
    static func getWeakDay(_ date:Date = Date()) -> Int{
        
        return Calendar.current.component(.weekday, from: date) - 1
    }
    //计算当月天数
    static func  getDaysInCurrentMonth() ->  Int  {
        
        let  calendar =  NSCalendar.current
        let  nowComps = calendar.dateComponents([.year,.month], from: Date())
        let  year =  nowComps.year!
        let  month = nowComps.month!
        
        let  startComps = DateComponents(year: year, month:month,day:1)
        let endMonth = month == 12 ? 1 : month + 1
        let endYear = month == 12 ? year + 1 : year
        let  endComps = DateComponents(year: endYear, month:endMonth,day:1)
        let diff = calendar.dateComponents([.day], from: startComps, to: endComps)
        return  diff.day!
    }
}
extension Date{

    /// 将日期转化为字符串
    /// - Parameter formatter: 格式
    /// - Returns: 日期字符串
    func toString(with formatterStyle:String = "YYYY.MM.dd HH:mm:ss") -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = formatterStyle
        return formatter.string(from: self)
    }
}
