//
//  AudioViewController.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 16/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class AudioViewController: MediaViewController {
    
    let audioTableView = AudiosTableView(frame: .zero, style: .plain)
    var audioPlayerView: AudioPlayer!
    var audioManager: AudioRecordManager!
    var selectedAudio: Audio?
    var audioDuration: TimeInterval?
        
    let recordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        
        audioManager = AudioRecordManager()
        audioManager.recordDelegate = self
        audioManager.requestAudioRecordPermission()
        
        audioPlayerView = AudioPlayer()
        audioPlayerView.playDelegate = self
        audioManager.playDelegate = self
        
        setupView()
    }
    
    @objc func recordButtonTapped() {
        if audioManager.audioRecorder == nil {
            audioManager.startRecording()
        } else {
            audioManager.finishRecording(success: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        audioManager.stopAudio()
    }
    
}

extension AudioViewController: ViewCode {
    
    func buildViewHierarchy() {
        self.contentView.addSubviews([audioTableView, audioPlayerView, recordButton])
    }
    
    func setupConstraints() {
        setupTableViewConstraints()
        setupAudioPlayerConstraints()
        setupRecordButtonConstraints()
    }
    
    func setupAdditionalConfigurantion() {
        audioTableView.dataSource = self
        audioTableView.delegate = self
    }
    
}

extension AudioViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audioManager.recordedAudios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = audioTableView.dequeueReusableCell(withIdentifier: "AudioCell")
        cell?.textLabel?.text = audioManager.recordedAudios[indexPath.row].name
        cell?.detailTextLabel?.text = "ALooooo"
        return cell ?? UITableViewCell()
    }
    
}

extension AudioViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAudio = audioManager.recordedAudios[indexPath.row]
        audioDuration = selectedAudio?.audioSize
        
        guard let audioName = selectedAudio?.name else { return }
        audioPlayerView.setTitleLabelText(audioName: audioName)
        
        guard let duration = audioDuration else { return }
        audioPlayerView.setPlayerLeftLabel(currentTime: audioManager.audioPlayer.currentTime)
        audioPlayerView.setPlayerRightLabel(audioDuration: duration)
        
    }
}

extension AudioViewController {
    
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            audioTableView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            audioTableView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.95),
            audioTableView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.35),
            audioTableView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16)
        ])
    }
    
    func setupAudioPlayerConstraints() {
        NSLayoutConstraint.activate([
            audioPlayerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            audioPlayerView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.95),
            audioPlayerView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.3),
            audioPlayerView.topAnchor.constraint(equalTo: self.audioTableView.bottomAnchor, constant: 16)
        ])
    }
    
    func setupRecordButtonConstraints() {
        NSLayoutConstraint.activate([
            recordButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            recordButton.widthAnchor.constraint(equalToConstant: 80),
            recordButton.heightAnchor.constraint(equalToConstant: 80),
            recordButton.topAnchor.constraint(equalTo: self.audioPlayerView.bottomAnchor, constant: 64)
        ])
    }
    
}

extension AudioViewController: AudioRecordDelegate {
    
    func didFinishRecord() {
        self.recordButton.setTitle("Tap to Re-record", for: .normal)
        audioTableView.reloadData()
    }
    
    func didBeginRecord() {
        self.recordButton.setBackgroundColor(color: .blue, forState: .normal)
    }
    
}

extension AudioViewController: AudioPlayerDelegate {
    func didTapPause() {
        audioManager.pauseAudio()
        audioPlayerView.isPlaying = false
    }
    
    
    func didTapFastForwardButton() {
        audioManager.fastForward()
    }
    
    func didTapFastBackwardButton() {
        audioManager.fastBackward()
    }
    
    func didBeginPlay() {
        guard let path = selectedAudio?.path else { return }
        audioManager.playAudio(withPath: path)
        audioPlayerView.isPlaying = true
    }
    
    func updateProgressView() {
        if self.audioManager.audioPlayer.isPlaying {
            guard let duration = audioDuration else { return }
            self.audioPlayerView.progressBar.setProgress(Float(audioManager.audioPlayer.currentTime / duration), animated: true)
            audioPlayerView.setPlayerLeftLabel(currentTime: audioManager.audioPlayer.currentTime)
            audioPlayerView.setPlayerRightLabel(audioDuration: duration - audioManager.audioPlayer.currentTime)
        }
    }
    
    func didFinishPlay(isPlaying: Bool) {
        audioPlayerView.playButton.setBackgroundColor(color: .systemPink, forState: .normal)
        audioPlayerView.progressBar.setProgress(0, animated: false)
        audioPlayerView.setPlayerFlag(isPlaying: isPlaying)
        audioPlayerView.setPlayButtonState()
        
        
        guard let duration = audioDuration else { return }
        audioPlayerView.setPlayerLeftLabel(currentTime: audioManager.audioPlayer.currentTime)
        audioPlayerView.setPlayerRightLabel(audioDuration: duration)
    }
    
}
