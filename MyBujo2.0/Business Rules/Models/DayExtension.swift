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
let happyT = NSLocalizedString("Happy",
comment: "Happy")
let sadT = NSLocalizedString("Sad",
comment: "Sad")
let angryT = NSLocalizedString("Angry",
comment: "Angry")
let anxiouaT = NSLocalizedString("Anxious",
comment: "Anxious")
let indiferentT = NSLocalizedString("Indiferent",
comment: "Indiferent")
let gratefulT = NSLocalizedString("Grateful",
comment: "Grateful")
let surprisedT = NSLocalizedString("Surprised",
comment: "Surprised")
let tiredT = NSLocalizedString("Tired",
comment: "Tired")
enum Feeling: String {
    case happy = "Happy"
    case sad = "Sad"
    case angry = "Angry"
    case anxious = "Anxious"
    case indiferent = "Indiferent"
    case grateful = "Grateful"
    case surprised = "Surprised"
    case tired = "Tired"
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    var color: UIColor {
        switch self {
        case .happy:
            return UIColor(named: "Happy") ?? UIColor.yellow
        case .sad:
            return UIColor(named: "Sad") ?? UIColor.darkGray
        case .angry:
            return UIColor(named: "Angry") ?? UIColor.red
        case .anxious:
            return UIColor(named: "Anxious") ?? UIColor.purple
        case .indiferent:
            return UIColor(named: "Indiferent") ?? UIColor.gray
        case .grateful:
            return UIColor(named: "Grateful") ?? UIColor.systemYellow
        case .surprised:
            return UIColor(named: "Surprised") ?? UIColor.systemBlue
        case .tired:
            return UIColor(named: "Tired") ?? UIColor.systemGray
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
