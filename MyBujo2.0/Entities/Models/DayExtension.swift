//
//  DayExtension.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 29/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import CoreData
import UIKit

enum Feeling: String {
    case happy = "Happy"
    case sad = "Sad"
    case angry = "Angry"
    case anxious = "Anxious"
    case indiferent = "Indiferent"
    
    var color: UIColor {
        switch self {
        case .happy:
            return UIColor(displayP3Red: 248/255, green: 231/255, blue: 28/255, alpha: 1)
        case .sad:
            return UIColor(displayP3Red: 60/255, green: 89/255, blue: 122/255, alpha: 1)
        case .angry:
            return UIColor(displayP3Red: 255/255, green: 59/255, blue: 48/255, alpha: 1)
        case .anxious:
            return UIColor(displayP3Red: 88/255, green: 86/255, blue: 214/255, alpha: 1)
        case .indiferent:
            return UIColor(displayP3Red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
        }
    }
}
    

extension Day {
    
    var feeling: Feeling? {
        get {
            guard let feeling = feel  else { return nil}
            return Feeling(rawValue: feeling) ?? nil
        }
        set {
            guard let feeling = newValue?.rawValue else { return }
            feel = feeling
        }
    }
    
    func save() {
        CoreDataManager.save()
    }
}
