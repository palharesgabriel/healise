//
//  DateExtension.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 29/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
extension Date{
    func ignoringTime() -> Date? {
        let components = Calendar.current.dateComponents([.day,.month,.year], from: self)
        return Calendar.current.date(from: components)
    }
}
