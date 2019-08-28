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

class CoreDataManager: NSObject{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getDay(date: Date) -> DayCD?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DayCD")
        request.predicate = NSPredicate(format: "date == %@", date as NSDate)
        
        do{
            let result = try? context.fetch(request)
            guard let day = result?.first as? DayCD  else { return nil }
            return day
        }
    }
}
