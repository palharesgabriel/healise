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
    case grateful = "Grateful"
    case surprised = "Surprised"
    case tired = "Tired"
    
    var color: UIColor {
        switch self {
        case .happy:
            return UIColor(named: "Happy")!
        case .sad:
            return UIColor(named: "Sad")!
        case .angry:
            return UIColor(named: "Angry")!
        case .anxious:
            return UIColor(named: "Anxious")!
        case .indiferent:
            return UIColor(named: "Indiferent")!
        case .grateful:
            return UIColor(named: "Grateful")!
        case .surprised:
            return UIColor(named: "Surprised")!
        case .tired:
            return UIColor(named: "Tired")!
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
