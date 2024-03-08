//
//  Date+.swift
//  Petmily.ios
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import Foundation

extension Date {
    /**
     @static
     
     @brief format 형태로 입력한 Date를 String형태로 리턴
     
     @return String
     */
    static func stringFromDate(date: Date, format: String = "yyyy-MM-dd HH:mm") -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.timeZone = .current
        dateFormatter.formatterBehavior = .default
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale.init(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }
    /**
     @static
     
     @brief 'yyyy-MM-dd HH:mm'형태로 입력한 문자열을 Date형태로 리턴
     
     @return Date
     */
    static func dateFromyyyyMMddHHmm(str: String?) -> Date? {
        if let dateString = str {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = .current
            dateFormatter.locale = Locale.init(identifier: "ko_KR")
            dateFormatter.formatterBehavior = .default
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            return dateFormatter.date(from: dateString)
        }
        return Date()
    }
}
