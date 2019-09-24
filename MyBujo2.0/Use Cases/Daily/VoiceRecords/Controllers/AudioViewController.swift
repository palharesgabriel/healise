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
    var audioPlayer: AudioPlayer!
    var audioManager: AudioRecordManager!
    var selectedAudio: Audio?
    var audioDuration: TimeInterval?
    var audioCurrentTime: TimeInterval?
    let progress = Progress(totalUnitCount: 10)
    
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
        
        audioPlayer = AudioPlayer(title: "Palhares")
        audioPlayer.playDelegate = self
        
        setupView()
    }
    
    @objc func recordButtonTapped() {
        if audioManager.audioRecorder == nil {
            audioManager.startRecording()
        } else {
            audioManager.finishRecording(success: true)
            audioTableView.reloadData()
        }
    }
    
}

extension AudioViewController: ViewCode {
    
    func buildViewHierarchy() {
        self.contentView.addSubviews([audioTableView, audioPlayer, recordButton])
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
        return cell ?? UITableViewCell()
    }
    
}

extension AudioViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAudio = audioManager.recordedAudios[indexPath.row]
        audioDuration = selectedAudio?.audioSize
        audioCurrentTime = selectedAudio?.currentAudioTime
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
            audioPlayer.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            audioPlayer.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.95),
            audioPlayer.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.3),
            audioPlayer.topAnchor.constraint(equalTo: self.audioTableView.bottomAnchor, constant: 16)
        ])
    }
    
    func setupRecordButtonConstraints() {
        NSLayoutConstraint.activate([
            recordButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            recordButton.widthAnchor.constraint(equalToConstant: 80),
            recordButton.heightAnchor.constraint(equalToConstant: 80),
            recordButton.topAnchor.constraint(equalTo: self.audioPlayer.bottomAnchor, constant: 64)
        ])
    }
    
}

extension AudioViewController: ChangeRecordButtonStateDelegate {
    
    func didFinishPlay() {
        self.audioPlayer.playButton.setBackgroundColor(color: .systemPink, forState: .normal)
    }
    
    func didFinishRecord() {
        self.recordButton.setTitle("Tap to Re-record", for: .normal)
    }
    
    func didBeginRecord() {
        self.recordButton.setBackgroundColor(color: .blue, forState: .normal)
    }
    
}

extension AudioViewController: AudioPlayerDelegate {
    
    func didBeginPlay() {
        guard let path = selectedAudio?.path else { return }
        audioManager.playAudio(withPath: path)
    }
    
    func updateProgressView() {
       
    }
    
}
