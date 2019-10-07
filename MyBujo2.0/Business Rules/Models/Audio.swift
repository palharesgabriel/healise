//
//  Audio.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 23/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation

class Audio {
    
//    required init?(contentsOfFile path: String) {
//
//    }
//
//    func dataRepresentation() -> Data? {
//
//    }
//
//    var relativePathName: String
    
    let name: String
    let path: URL
    var audioSize: TimeInterval

    var currentAudioTime: TimeInterval = 0
    
    init(name: String, path: URL, audioSize: TimeInterval) {
        self.name = name
        self.path = path
        self.audioSize = audioSize
    }
}
