//
//  CalendarStructs.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 26/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation

struct Year {
    var months: [Int: Month]
    var representation: Int
    init() {
        months = [Int: Month]()
        representation = 1970
    }
    
}

struct Month {
    var daysIn: [Date]
    var daysOut: [Date]
    var days: [Date]
    var representation: Int
    
    init() {
        daysIn = [Date]()
        daysOut = [Date]()
        days = [Date]()
        representation = 0
    }
}
