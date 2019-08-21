//
//  CalendarManager.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 19/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation

class CalendarManager: NSObject{
    
    private override init() {
        super.init()
        fillYear(year: Calendar.current.component(.year, from: Date()))
        year.representation = Calendar.current.component(.year, from: Date())
    }
    
    static let shared = CalendarManager()
    
    var year = Year()
    
    var currentDay = Calendar.current.component(.day, from: Date())
    var currentMonth = Calendar.current.component(.month, from: Date())
    var currentYear = Calendar.current.component(.year, from: Date())
    
    
    func fillYear(year: Int){
        let diff = year - currentYear
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        guard var date = dateFormatter.date(from: "\(currentYear + diff) 01 01") else { return }
        
        
        
        for i in 1...12{
            self.year.months[i] = Month()
            self.year.months[i]?.representation = i
        }
        
        for _ in 1...365{
            if Calendar.current.component(.year, from: date) == currentYear{
                self.year.months[Calendar.current.component(.month, from: date)]?.days.append(date)
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            }
        }
        
        for i in 1...12{
            fillDaysInAndOut(month: i)
        }
    }
    
    
    func fillDaysInAndOut(month: Int){
        var monthReference = year.months[month]!
        var firstDay = monthReference.days.first!
        var lastDay = monthReference.days.last!
        let firstWeekDay = getFirstWeekDayOfMonth(month: month)
        
        
        for i in 0..<firstWeekDay-1{
            firstDay = Calendar.current.date(byAdding: .day, value: -1, to: firstDay)!
            monthReference.daysIn.append(firstDay)
        }
        monthReference.daysIn.sort(by: <)
        
        
        
        
        let numberOfDaysOut = 6 * 7 - monthReference.days.count - monthReference.daysIn.count
        for i in 0..<numberOfDaysOut{
            lastDay = Calendar.current.date(byAdding: .day, value: 1, to: lastDay)!
            monthReference.daysOut.append(lastDay)
        }
        year.months[month] = monthReference
    }
    
    func getDaysInMonth(month: Int) -> Int{
        return (year.months[month]?.days.count)!
    }
    
    func getFirstWeekDayOfMonth(month: Int) -> Int{
        return Calendar.current.component(.weekday, from: (year.months[month]?.days.first)!)
    }
}


struct Year{
    var months: [Int: Month]
    var representation: Int
    init() {
        months = [Int: Month]()
        representation = 1970
    }
    
}

struct Month{
    var daysIn: [Date]
    var daysOut: [Date]
    var days: [Date]
    var representation: Int
    
    init(){
        daysIn = [Date]()
        daysOut = [Date]()
        days = [Date]()
        representation = 0
    }
}
