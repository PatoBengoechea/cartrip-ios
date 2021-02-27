//
//  DateHelper.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 06/12/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

class DateHelper: NSObject {
    static func todayLong() -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.setLocalizedDateFormatFromTemplate("EEEE, d MMMM")
        let date = formatter.string(from: Date())
        return date
    }
    
    enum Style {
        case short, medium, long
    }
    
    static func year(_ style: Style) -> String {
        switch style {
        case .long:
            return "yyyy"
        case .medium:
            return "yyy"
        case .short:
            return "yy"
        }
    }
    
    static func month(_ style: Style) -> String {
        switch style {
        case .long:
            return "MMMM"
        case .medium:
            return "MMM"
        case .short:
            return "MM"
        }
    }
    
    static func weekDay(_ style: Style) -> String {
        switch style {
        case .long:
            return "EEEE"
        case .medium:
            return "EEE"
        case .short:
            return "EE"
        }
    }
    
    static func dayNumber( _ style: Style) -> String {
        switch style {
        case .long:
            return "dd"
        case .short:
            return "d"
        default:
            return ""
        }
    }
    
    static func parseMinutes(seconds: Int) -> String {
        let (hrs, min, _) = secondsToHoursMinutesSeconds(seconds: seconds)
        var str = ""
        if hrs != 0 {
            str.append("\(hrs)hrs ")
        }
        if hrs != 0 && min != 0 {
            str.append("y ")
        }
        if min != 0 {
            str.append("\(min)min")
        }
        return str
    }
    
    private static func secondsToHoursMinutesSeconds (seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    static func calcAge(birthday: Date) -> Int {
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthday, to: now, options: [])
        let age = calcAge.year
        return age!
    }
    
    static func dateLong(fromDateWithFullTime date: String) -> String {
        let dateParsed = DateParsed(date, format: .dateWithFullTime)
        return dateParsed?.dateLong() ?? "error"
    }
}

struct DateParsed {
    var string: String
    private var format: DateFormat
    var date: Date?
    private var fullDate: DateComponents?
    
    init?(_ date: String?, format: DateFormat) {
        guard let stringDate = date else { return nil}
        string = stringDate
        self.format = format
        self.date = toDate(from: stringDate)
        fullDate = parseDate(time: stringDate)
    }
    
    enum DateFormat {
        case dateWithFullTime
        case dateWithTime
        case dateWithFullYear
        var value: String {
            switch self {
            case .dateWithFullTime:
                return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            case .dateWithFullYear:
                return "yyy-MM-dd"
            case .dateWithTime:
                return "yyyy-MM-dd'T'HH:mm:ss"
            }
        }
        
    }
    
    private func toDate(from stringDate: String?) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        dateFormatter.dateFormat = format.value
        guard let string = stringDate else { return nil}
        let date = dateFormatter.date(from: string)
        
        return date
    }
    
    private func parseDate(time: String) -> DateComponents? {
        
        var calendar = Calendar.current
        if let timeZone = NSTimeZone(name: "UTC") as TimeZone? {
            calendar.timeZone = timeZone
        } else { return nil}
        guard let dateTime = date else { return nil }
        switch format {
        case .dateWithFullYear:
            let components = calendar.dateComponents([.year, .month, .day, .weekday], from: dateTime)
            return components
        case .dateWithFullTime:
            let components = calendar.dateComponents([.year, .month, .day, .weekday, .hour, .minute, .second], from: dateTime)
            return components
        case .dateWithTime:
            let components = calendar.dateComponents([.year, .month, .day, .weekday, .hour, .minute], from: dateTime)
            return components
        }
    }
    
    func dayWithNumber(style: DateHelper.Style) -> String {
        guard let dateUn = date else { return "" }
        if Calendar.autoupdatingCurrent.isDateInToday(dateUn) {
            return "Hoy"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = DateHelper.weekDay(style)
        var dayInWeek = formatter.string(from: dateUn)
        if let dayNumber = fullDate?.day {
            dayInWeek.append(" \(dayNumber)")
        }
        return dayInWeek
    }
    
    func isToday() -> Bool {
        guard let dateUn = date else { return false }
        return Calendar.autoupdatingCurrent.isDateInToday(dateUn)
    }
    
    func dateLong() -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.setLocalizedDateFormatFromTemplate("dd, MMMM yyy")
        guard let dateUn = date else { return "" }
        let date = formatter.string(from: dateUn)
        return date
    }
}

