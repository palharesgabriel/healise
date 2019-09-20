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
    
    var audioRecorder: AVAudioRecorder?
    
    var audioPlayer: AVAudioPlayer
    
    override init() {
        self.recordingSession = AVAudioSession.sharedInstance()
        self.audioPlayer = AVAudioPlayer()
        self.audioRecorder = AVAudioRecorder()
    }
    
    func requestAudioRecordPermission() {
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
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
        let audioFilename = FileManager.createDirectory(day: self.getDay(), directoryOf: .voiceRecord).appendingPathComponent("recording.m4a")
        
        guard let recorder = self.audioRecorder else { return }
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            recorder.delegate = self
            recorder.record()
            // faça coisas
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        guard let recorder = self.audioRecorder else { return }
        recorder.stop()
        self.audioRecorder = nil
        
        if success {
            // faça coisas
        } else {
            // recording failed :(
        }
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
