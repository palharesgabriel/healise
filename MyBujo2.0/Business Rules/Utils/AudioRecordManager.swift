//
//  AudioRecordManager.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 20/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import AVFoundation
import UIKit

class AudioRecordManager: NSObject {
    
    var recordingSession: AVAudioSession
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var audioPath: URL!
    var recordDelegate: ChangeRecordButtonStateDelegate?
    var playDelegate: AudioPlayerDelegate?
    var recordedAudios: [Audio] = []
    let fileManager = FileManager.default
    var playbackTimer: Timer
    
    override init() {
        recordingSession = AVAudioSession.sharedInstance()
        playbackTimer = Timer()
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
            let player = setupPlayer(withAudioPath: audioPath)
            let audio = Audio(name: getCurrentTime(), path: audioPath, audioSize: player.duration)
            recordedAudios.append(audio)
            recordDelegate?.didFinishRecord()
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
    
    func setupPlayer(withAudioPath: URL) -> AVAudioPlayer {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: withAudioPath)
            recordedAudios.last?.audioSize = audioPlayer.duration
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
            
        } catch {
            print(error)
        }
        return audioPlayer
    }
    
    func playAudio(withPath: URL) {
        let player = setupPlayer(withAudioPath: withPath)
        player.play()
        playDelegate?.didFinishPlay()
        startPlaybackTimer()
    }
    
    func startPlaybackTimer() {
        playbackTimer.invalidate()
        playbackTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
            
        playbackTimer.fire()
    }

    @objc func updateProgressView() {
        playDelegate?.updateProgressView()
        print("ok")
    }
    
}

extension AudioRecordManager: AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playbackTimer.invalidate()
        playDelegate?.didFinishPlay()
        print("acabou")
    }
    
}
