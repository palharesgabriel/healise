//
//  GoalExtension.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 29/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation

extension Goal {
    
    func save(){
        CoreDataManager.save()
    }
}
