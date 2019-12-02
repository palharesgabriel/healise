//
//  CalendarManager.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 19/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation

class CalendarManager: NSObject {
    
    private override init() {
        super.init()
        fillYear(year: Calendar.current.component(.year, from: Date()))
        year.representation = Calendar.current.component(.year, from: Date())
    }
    
    static let shared = CalendarManager()
    
    var year = Year()
    
    lazy var selectedDay: Day = self.getDay(date: Date())
    
    
    var currentDayComponent = Calendar.current.component(.day, from: Date())
    var currentMonthComponent = Calendar.current.component(.month, from: Date())
    var currentYearComponent = Calendar.current.component(.year, from: Date())
    lazy var selectedMonthComponent: Int = {
        return currentMonthComponent
    }()
    
    func getDay(date: Date) -> Day {
        guard let result = CoreDataManager.fetch(entityClass: Day.self, predicate: EntityType.day(date).predicate)?.first as? Day else {
            let day = Day(context: CoreDataManager.context)
            guard let dateIgnoringTime = date.ignoringTime() else { return day}
            day.date = dateIgnoringTime
            let media = Media(context: CoreDataManager.context)
            media.photosPath = FileManager.default.createDirectory(day: day, directoryOf: .photo)
            media.videosPath = FileManager.default.createDirectory(day: day, directoryOf: .video)
            media.voiceRecordsPath = FileManager.default.createDirectory(day: day, directoryOf: .voiceRecord)
            day.media = media
            day.save()
            return day
        }
         return result
    }
    
    func getDaysInMonth(month: Int) -> Int {
        return (year.months[month]?.days.count)!
    }
    
    func getFirstWeekDayOfMonth(month: Int) -> Int {
        return Calendar.current.component(.weekday, from: (year.months[month]?.days.first)!)
    }
    
    private func fillYear(year: Int) {
        let diff = year - currentYearComponent
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        guard var date = dateFormatter.date(from: "\(currentYearComponent + diff) 01 01") else { return }
        
        
        
        for index in 1...12 {
            self.year.months[index] = Month()
            self.year.months[index]?.representation = index
        }
        
        for _ in 1...365 {
            if Calendar.current.component(.year, from: date) == currentYearComponent {
                self.year.months[Calendar.current.component(.month, from: date)]?.days.append(date)
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            }
        }
        
        for index in 1...12 {
            fillDaysInAndOut(month: index)
        }
    }
    
    
    private func fillDaysInAndOut(month: Int) {
        var monthReference = year.months[month]!
        var firstDay = monthReference.days.first!
        var lastDay = monthReference.days.last!
        let firstWeekDay = getFirstWeekDayOfMonth(month: month)
        
        
        for _ in 0..<firstWeekDay - 1 {
            firstDay = Calendar.current.date(byAdding: .day, value: -1, to: firstDay)!
            monthReference.daysIn.append(firstDay)
        }
        monthReference.daysIn.sort(by: <)
        
        
        
        
        let numberOfDaysOut = 6 * 7 - monthReference.days.count - monthReference.daysIn.count
        for _ in 0..<numberOfDaysOut {
            lastDay = Calendar.current.date(byAdding: .day, value: 1, to: lastDay)!
            monthReference.daysOut.append(lastDay)
        }
        year.months[month] = monthReference
    }
}
