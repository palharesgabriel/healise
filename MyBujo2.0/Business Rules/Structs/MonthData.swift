//
//  Month.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 26/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation

typealias FeelingNumber = (feeling: Feeling, number: Double)


struct MonthData {
    
    var feelingsNumber: [FeelingNumber] = {
        Feeling.allCases.map({($0,0)})
    }()
    
    
    var numberOfNotes = 0
    var numberOfDrawings = 0
    var numberOfVoiceRecords = 0
    var numberOfVideos = 0
    var numberOfPhotos = 0
    var numberOfGoals = 0
}
