//
//  AudioViewController.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 16/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
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
    
    let shadowView = ShadowView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "BlueBackground")
        self.contentView.backgroundColor = UIColor(named: "BlueBackground")
        audioManager = AudioRecordManager()
        audioManager.recordDelegate = self
        audioManager.requestAudioRecordPermission()
        
        audioPlayerView = AudioPlayer()
        
        audioPlayerView.playDelegate = self
        audioManager.playDelegate = self
        
        setupView()
        
        guard let audios = CalendarManager.shared.selectedDay.media?.audios else { return }
        audioManager.recordedAudios = audios
        
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

@available(iOS 13.0, *)
extension AudioViewController: ViewCode {
    
    func buildViewHierarchy() {
        self.contentView.addSubviews([shadowView, audioTableView, audioPlayerView, recordButton])
    }
    
    func setupConstraints() {
        setupTableViewConstraints()
        setupAudioPlayerConstraints()
        setupRecordButtonConstraints()
        setupShadowViewConstraints()
    }
    
    func setupAdditionalConfigurantion() {
        audioTableView.dataSource = self
        audioTableView.delegate = self
    }
    
}

@available(iOS 13.0, *)
extension AudioViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audioManager.recordedAudios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = audioTableView.dequeueReusableCell(withIdentifier: "AudioCell")
        cell?.textLabel?.text = audioManager.recordedAudios[indexPath.row].name
        cell?.textLabel?.textColor = UIColor(named: "TitleColor")
        cell?.backgroundColor = UIColor(named: "CardsColor")
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            audioManager.recordedAudios.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

@available(iOS 13.0, *)
extension AudioViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAudio = audioManager.recordedAudios[indexPath.row]
        audioDuration = selectedAudio?.audioSize
        
        guard let audioName = selectedAudio?.name else { return }
        audioPlayerView.setTitleLabelText(audioName: audioName)
        
        guard let duration = audioDuration else { return }
        audioPlayerView.setPlayerLeftLabel(currentTime: (selectedAudio?.audioPlayer.currentTime)!)
        audioPlayerView.setPlayerRightLabel(audioDuration: duration)
    }
    
}

@available(iOS 13.0, *)
extension AudioViewController {
    
    func setupShadowViewConstraints() {
        NSLayoutConstraint.activate([
            shadowView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            shadowView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.9),
            shadowView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.4),
            shadowView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16)
        ])
    }
    
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            audioTableView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            audioTableView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.9),
            audioTableView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.4),
            audioTableView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16)
        ])
    }
    
    func setupAudioPlayerConstraints() {
        NSLayoutConstraint.activate([
            audioPlayerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            audioPlayerView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.9),
            audioPlayerView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.3),
            audioPlayerView.topAnchor.constraint(equalTo: self.audioTableView.bottomAnchor, constant: 16)
        ])
    }
    
    func setupRecordButtonConstraints() {
        NSLayoutConstraint.activate([
            recordButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            recordButton.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.25),
            recordButton.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.15),
            recordButton.topAnchor.constraint(equalTo: self.audioPlayerView.bottomAnchor, constant: 28)
        ])
    }
    
}

@available(iOS 13.0, *)
extension AudioViewController: AudioRecordDelegate {
    
    func didFinishRecord() {
        self.recordButton.setTitle("Tap to Re-record", for: .normal)
        audioTableView.reloadData()
    }
    
    func didBeginRecord() {
        self.recordButton.setBackgroundColor(color: .blue, forState: .normal)
    }
    
}

@available(iOS 13.0, *)
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
        recordButton.isUserInteractionEnabled = false
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
        audioPlayerView.progressBar.setProgress(0, animated: false)
        audioPlayerView.setPlayerFlag(isPlaying: isPlaying)
        audioPlayerView.setPlayButtonState()
        
        
        guard let duration = audioDuration else { return }
        audioPlayerView.setPlayerLeftLabel(currentTime: audioManager.audioPlayer.currentTime)
        audioPlayerView.setPlayerRightLabel(audioDuration: duration)
        
        recordButton.isUserInteractionEnabled = true
    }
    
}
