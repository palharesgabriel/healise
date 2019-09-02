//
//  DayExtension.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 29/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import CoreData

enum Feeling: String{
    case happy = "Happy"
    case sad = "Sad"
    case anger = "Anger"
    case lovely = "Lovely"
    case tired = "Tired"
}

extension Day {
    
    var feeling: Feeling?{
        get{
            guard let feeling = feel  else { return nil}
            return Feeling(rawValue: feeling) ?? nil
        }
        set{
            guard let feeling = newValue?.rawValue else{ return }
            feel = feeling
        }
    }
    
    func save() {
        CoreDataManager.save()
    }
}
