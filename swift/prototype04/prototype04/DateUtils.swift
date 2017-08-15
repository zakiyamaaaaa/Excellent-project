//
//  DateUtils.swift
//  prototype04
//
//  Created by shoichiyamazaki on 2017/07/30.
//  Copyright © 2017年 shoichiyamazaki. All rights reserved.
//

import Foundation

class DateUtils {
    
    static func age(byBirthDate birthDate: Date) -> Int {
        let timezone: NSTimeZone = NSTimeZone.system as NSTimeZone
        let localDate = NSDate(timeIntervalSinceNow: Double (timezone.secondsFromGMT)) as Date
        
        let localDateIntVal = Int(string(localDate, format: "yyyyMMdd"))
        let birthDateIntVal = Int(string(birthDate, format: "yyyyMMdd"))
        
        print(localDateIntVal!)
        print(birthDateIntVal!)
        
        let age = (localDateIntVal! - birthDateIntVal!) / 10000
        print(age)
        
        return age
    }
    
//    class func dateFromString(string: String, format: String) -> Date {
//        let formatter: DateFormatter = DateFormatter()
//        formatter.calendar = Calendar(identifier: .gregorian)
//        formatter.dateFormat = format
//        return formatter.date(from: string)! as Date
//    }
    
    static func date(_ string: String, format: String) -> Date {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: string)! as Date
    }
    
    static func string(_ date: Date, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date as Date)
    }
    
    static func simpleDate(string: String) -> String {
        let tmp = string.replacingOccurrences(of: "-", with: "/")
        let res = tmp.substring(from: tmp.index(tmp.startIndex, offsetBy: 5))
        return res
    }
    
}
