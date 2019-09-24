//
//  ChangeRecordButtonStateDelegate.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 23/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation

protocol ChangeRecordButtonStateDelegate {
    func didBeginRecord()
    func didFinishRecord()
}