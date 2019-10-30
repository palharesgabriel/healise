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
    weak var recordDelegate: AudioRecordDelegate?
    weak var playDelegate: AudioPlayerDelegate?
    var recordedAudios: [Audio] = []
    let fileManager = FileManager.default
    var playbackTimer: Timer
    
    override init() {
        recordingSession = AVAudioSession.sharedInstance()
        playbackTimer = Timer()
    }
    
    func requestAudioRecordPermission() {
        do {
            try recordingSession.setCategory(.playAndRecord, options: .defaultToSpeaker)
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
    
    func getFileManagerPath() {
        let mainPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        guard let media = getDay().media else { return }
        guard let recordsPath = media.voiceRecordsPath else { return }
        self.audioPath = mainPath.appendingPathComponent(recordsPath).appendingPathComponent(getCurrentTime())
    }
    
    func startRecording() {
        
        getFileManagerPath()
        
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
        
        let player = setupPlayer(withAudioPath: audioPath)
        
        if success {
            let audio = Audio(name: getCurrentTime(), path: audioPath, audioSize: getAudioDuration(), audioPlayer: player)
            recordedAudios.insert(audio, at: 0)
            recordDelegate?.didFinishRecord()
        } else {
            print("failed to record")
        }
    }
    
    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        let hourString = formatter.string(from: Date())
        return hourString
    }
    
    func setupPlayer(withAudioPath: URL) -> AVAudioPlayer {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: withAudioPath)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
            
        } catch {
            print(error)
        }
        return audioPlayer
    }
    
    func getAudioDuration() -> TimeInterval {
        let player = setupPlayer(withAudioPath: audioPath)
        return player.duration
    }
    
    func playAudio(withPath: URL) {
        let player = setupPlayer(withAudioPath: withPath)
        if !player.isPlaying {
            player.play()
        }
        startPlaybackTimer()
    }
    
    func stopAudio() {
        guard let player = audioPlayer else { return }
        player.stop()
        player.currentTime = 0.0
        playDelegate?.didFinishPlay(isPlaying: false)
    }
    
    func pauseAudio() {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        }
    }
    
    func fastForward() {
        if audioPlayer != nil {
            if audioPlayer.isPlaying {
                 var time = audioPlayer.currentTime
                 time += 5.0
                 if time >= audioPlayer.duration {
                     stopAudio()
                 } else {
                     audioPlayer.currentTime = time
                 }
             }
        }
    }
    
    func fastBackward() {
        if audioPlayer != nil {
            if audioPlayer.isPlaying {
                var time: TimeInterval = audioPlayer.currentTime
                time -= 5.0
                if time <= 0 {
                    stopAudio()
                } else {
                    audioPlayer.currentTime = time
                }
            }
        }
    }
    
    func startPlaybackTimer() {
        playbackTimer.invalidate()
        playbackTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
        playbackTimer.fire()
    }

    @objc func updateProgressView() {
        playDelegate?.updateProgressView()
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
        playDelegate?.didFinishPlay(isPlaying: player.isPlaying)
    }
    
}
