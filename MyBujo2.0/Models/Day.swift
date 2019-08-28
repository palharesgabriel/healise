//
//  Day.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 28/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
class Day: NSObject{
    private var coreDataDay: DayCD
    var date: Date
    var feeling: String
    var media: Media
    
    init(coreDataDay: DayCD) {
        self.coreDataDay = coreDataDay
        feeling = coreDataDay.value(forKey: "feeling") as! String
        self.media = Media()
        self.date = Date()
    }
}
