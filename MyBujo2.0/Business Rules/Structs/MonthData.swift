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
    
    var numberOfFeelings: [Feeling:Double] = {
        var dict = [Feeling:Double]()
        Feeling.allCases.forEach({dict[$0] = 0})
        return dict
    }()
    
    var angry = 0
    var anxious = 0
    var happy = 0
    var grateful = 0
    var indiferent = 0
    var sad = 0
    var surprised = 0
    var tired = 0
    var numberOfNotes = 0
    var numberOfDrawings = 0
    var numberOfVoiceRecords = 0
    var numberOfVideos = 0
    var numberOfPhotos = 0
    var numberOfGoals = 0
}
