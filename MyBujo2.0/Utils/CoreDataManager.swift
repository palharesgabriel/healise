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

enum EntityType {
    case day(_: Date)
    case media
    case goal(_:Day)
    
    var predicate: NSPredicate {
        switch self {
        case .day(let date):
            guard let dateIgnoringTime = date.ignoringTime() else { return NSPredicate(value: false)}
            return NSPredicate(format: "date == %@", dateIgnoringTime as NSDate)
        case .goal(let day):
            guard let date = day.date else { return NSPredicate(value: false)}
            guard let dateIgnoringTime = date.ignoringTime() else { return NSPredicate(value: false)}
            return NSPredicate(format: "day.date == %@", dateIgnoringTime as NSDate)
        default:
            return NSPredicate(value: true)
        }
    }
}

extension NSManagedObject {
    static var className: String{
        get{
            return String(describing: self)
        }
    }
}


class CoreDataManager: NSObject {
    
    static var context: NSManagedObjectContext {
        get{
            guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else {
                fatalError("Can't load appDelegate")
            }
            return appDelegate.persistentContainer.viewContext
        }
    }
    
    
    static func fetch<T: NSManagedObject>(entityClass: T.Type, predicate: NSPredicate) -> [Any]?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityClass.className)
        request.predicate = predicate
        
        do{
            let result = try context.fetch(request)
            return result
        } catch {
            print("\(error.localizedDescription) buceta")
        }
        return nil
    }
    
    static func create<T: NSManagedObject>(entityType: T.Type, completion: ((NSManagedObject) -> Void)? = nil) {
        
        let entity = T(context: context)
        if let completion = completion {
            completion(entity)
            
        }
        save()
    }
    
    static func save() {
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}
