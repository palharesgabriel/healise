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

enum EntityType{
    case day(_: Date)
    case media
    case goal
    
    var predicate: NSPredicate{
        switch self {
        case .day(let date):
            return NSPredicate(format: "date == %@", date as NSDate)
        default:
            return NSPredicate(value: true)
        }
    }
    
    var name: String{
        switch self {
        case .day(_):
            return "DayCD"
        default:
            return "NULL"
        }
    }
}

class CoreDataManager: NSObject{
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func fetch(entityType: EntityType) -> Any?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityType.name)
        request.predicate = entityType.predicate
        
        do{
            let result = try? context.fetch(request)
            return result
        }
    }
    
    static func save(){
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}
