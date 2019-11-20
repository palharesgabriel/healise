//
//  CoreDataManager.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 28/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct DayData {
    var hasPhotosInDay = false
    var hasNotesInDay = false
    var hasAudiosInDay = false
    var hasDrawsInDay = false
}

enum EntityType {
    case day(_: Date)
    case media
    case goal(_: Day)
    case common(_: NSPredicate)
    
    var predicate: NSPredicate {
        switch self {
        case .day(let date):
            guard let dateIgnoringTime = date.ignoringTime() else { return NSPredicate(value: false)}
            return NSPredicate(format: "date == %@", dateIgnoringTime as NSDate)
        case .goal(let day):
            guard let date = day.date else { return NSPredicate(value: false)}
            guard let dateIgnoringTime = date.ignoringTime() else { return NSPredicate(value: false)}
            return NSPredicate(format: "day.date == %@", dateIgnoringTime as NSDate)
        case .common(let predicate):
            return predicate
        default:
            return NSPredicate(value: true)
        }
    }
}

extension NSManagedObject {
    static var className: String {
        return String(describing: self)
    }
}


class CoreDataManager: NSObject {
    
    static var context: NSManagedObjectContext {
            guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
                fatalError("Can't load appDelegate")
            }
            return appDelegate.persistentContainer.viewContext
    }
    
    
    static func fetch<T: NSManagedObject>(entityClass: T.Type, predicate: NSPredicate) -> [Any]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityClass.className)
        request.predicate = predicate
        
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print("\(error.localizedDescription) buceta")
        }
        return nil
    }
    
    static func fetch<T: NSManagedObject>(entityClass: T.Type, entityType: EntityType) -> [Any]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityClass.className)
        request.predicate = entityType.predicate
        
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print("\(error.localizedDescription) buceta")
        }
        return nil
    }
    
    static func getMonthData(month: Int) -> MonthData? {
        guard let days = fetch(entityClass: Day.self, predicate: NSPredicate(value: true)) as? [Day] else { return nil }
        
        let filteredDays = days.filter { (day) -> Bool in
            if let date = day.date, Calendar.current.component(.month, from: date) == month {
                return true
            }
            return false
        }
        
        var monthData = MonthData()
        
        filteredDays.forEach { (day) in
            if let goals = day.goals {
                monthData.numberOfGoals += goals.count
            }
            if let media = day.media {
                if media.drawing != nil {
                    monthData.numberOfDrawings += 1
                }
                if media.note != nil {
                    monthData.numberOfNotes += 1
                }
                if let photos = media.photos {
                    monthData.numberOfPhotos += photos.count
                }
            }
        }

        return monthData
    }
    
    static func getDayData(day: Date) -> DayData? {
//        Pega os dias da semana
        guard let days = fetch(entityClass: Day.self, predicate: NSPredicate(value: true)) as? [Day] else { return nil }
//        Filtra somente o dia que eu passei na função
        guard let filtredDay = days.filter({$0.date == day}).first else { return nil }
//        Instancia um DayData que vai ser retornado
        var dayDate = DayData()
//        Faz a validação do media.
        if let media  = filtredDay.media {
            if media.photos?.count != 0 {
                dayDate.hasPhotosInDay = true
            }
            if media.audios?.count != 0 {
                dayDate.hasAudiosInDay = true
            }
            if media.drawing != nil {
                dayDate.hasDrawsInDay = true
            }
            if media.note != nil {
                dayDate.hasNotesInDay = true
            }
        }
        return dayDate
    }
    
    static func save() {
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}
