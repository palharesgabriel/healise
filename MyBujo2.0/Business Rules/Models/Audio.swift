//
//  Audio.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 23/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import AVFoundation

class Audio: NSObject, FileManagerInitiable {
    
    var relativePathName: String {
        return name
    }
    
    var name: String
    var path: URL {
        didSet {
            print("mudei")
        }
    }
    var audioSize: TimeInterval
    var audioPlayer: AVAudioPlayer

    var currentAudioTime: TimeInterval = 0
    
    required convenience init?(contentsOfFile path: String) {
        let audioManager = AudioRecordManager()
        let player = audioManager.setupPlayer(withAudioPath: URL(string: path)!)
        let name = path.components(separatedBy: "VoiceRecords/")[1]
        self.init(name: name, path: URL(string: path)!, audioSize: player.duration, audioPlayer: player)
        audioPlayer = player
    }
    
    func dataRepresentation() -> Data? {
        return nil
    }
    
    init(name: String, path: URL, audioSize: TimeInterval, audioPlayer: AVAudioPlayer) {
        self.name = name
        self.path = path
        self.audioSize = audioSize
        self.audioPlayer = audioPlayer
    }
}
