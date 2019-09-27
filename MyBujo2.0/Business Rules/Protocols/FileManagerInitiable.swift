//
//  FileManagerInitiable.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 27/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation

protocol FileManagerInitiable {
    init?(contentsOfFile path: String)
    func dataRepresentation() -> Data?
    var relativePathName: String { get }
}
