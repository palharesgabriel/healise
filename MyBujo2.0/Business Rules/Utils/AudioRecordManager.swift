//
//  AudioRecordManager.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 20/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import AVFoundation

class AudioRecordManager: NSObject {
    
    var recordingSession: AVAudioSession
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var audioPath: URL!
    var recordDelegate: ChangeRecordButtonStateDelegate?
    var recordedAudios: [Audio] = []
    let fileManager = FileManager.default
    
    override init() {
        recordingSession = AVAudioSession.sharedInstance()
    }
    
    func requestAudioRecordPermission() {
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission { allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("Authorized")
                    } else {
                        print("failed to record, permission denied")
                    }
                }
            }
        } catch {
            print("failed to record")
        }
    }
    
    func getDay() -> Day {
        return CalendarManager.shared.selectedDay
    }
    
    func startRecording() {
        self.audioPath = fileManager.createDirectory(day: self.getDay(), directoryOf: .voiceRecord).appendingPathComponent(getCurrentTime())
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: audioPath, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            recordDelegate?.didBeginRecord()
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        guard let recorder = self.audioRecorder else { return }
        recorder.stop()
        self.audioRecorder = nil
        
        if success {
            recordDelegate?.didFinishRecord()
            let audio = Audio(name: getCurrentTime(), path: audioPath)
            recordedAudios.append(audio)
            
        } else {
            print("failed to record")
        }
    }
    
    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh-mm-ss a"
        let hourString = formatter.string(from: Date())
        return hourString
    }
    
    func playAudio(withPath: URL) {
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: withPath)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
        } catch {
            print(error)
        }
        audioPlayer.play()
        recordDelegate?.didFinishPlay()
    }
    
}

extension AudioRecordManager: AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
           if !flag {
               finishRecording(success: false)
           }
          // faça coisas
       }
    
}
