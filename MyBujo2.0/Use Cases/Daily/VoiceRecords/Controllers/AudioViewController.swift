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
    
    // MARK: Properties
    let audioTableView = AudiosTableView(frame: .zero, style: .plain)
    let recordButtonView = RecordButtonView()
    var selectedAudio: Audio?
    var audioDuration: TimeInterval?
    
    var audioPlayerView = AudioPlayer()
    var audioManager = AudioRecordManager()
    let shadowView = ShadowView()
    
    let day = CalendarManager.shared.selectedDay
	weak var delegateTarget: MediaCollectionViewTargetDelegate?
    
	override func viewWillAppear(_ animated: Bool) {
		localizableLabel()
	}
    func localizableLabel() {
        let formatStringGoalLabel = NSLocalizedString("Record",
                                             comment: "Record")
        self.title = String.localizedStringWithFormat(formatStringGoalLabel)
    }
    
    
    // MARK: Controller methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blueBackground
        self.contentView.backgroundColor = .blueBackground
        audioManager.requestAudioRecordPermission()
        
        audioPlayerView.playDelegate = self
        recordButtonView.recordButtonDelegate = self
        audioManager.recordDelegate = self
        audioManager.playDelegate = self
        
        setupView()
        
        guard let audios = day.media?.audios else { return }
        audioManager.recordedAudios = audios
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        audioManager.stopAudio()
        delegateTarget?.mediaTarget()
    }
    
    func setRecordButtonState() {
        if audioManager.audioRecorder != nil {
            recordButtonView.setButtonSelection(true)
        } else {
            recordButtonView.setButtonSelection(false)
        }
    }
    
    func animateRecordingView() {
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: .repeat, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.recordButtonView.recordButton.imageView?.alpha = 0.3
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.recordButtonView.recordButton.imageView?.alpha = 1.0
            })
        })
    }
    
    func presentNewAudioController() {
        let viewController = NewAudioViewController()
        self.present(viewController, animated: true, completion: nil)
    }
    
}

// MARK: View configuration
@available(iOS 13.0, *)
extension AudioViewController: ViewCode {
    
    func buildViewHierarchy() {
        self.contentView.addSubviews([shadowView, audioTableView, audioPlayerView, recordButtonView])
    }
    
    func setupConstraints() {
        setupTableViewConstraints()
        setupAudioPlayerConstraints()
        setupRecordButtonViewConstraints()
        setupShadowViewConstraints()
    }
    
    func setupAdditionalConfigurantion() {
        audioTableView.dataSource = self
        audioTableView.delegate = self
    }
}

// MARK: TableView methods
@available(iOS 13.0, *)
extension AudioViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audioManager.recordedAudios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = audioTableView.dequeueReusableCell(withIdentifier: "AudioCell")
        cell?.textLabel?.text = audioManager.recordedAudios[indexPath.row].name
        cell?.textLabel?.textColor = .titleColor
        cell?.backgroundColor = .cardsColor
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            audioManager.recordedAudios.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
			
            day.media?.remove(index: indexPath.row, mediaPath: (day.media!.voiceRecordsPath)!)
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
		guard let audio = selectedAudio?.audioPlayer.currentTime else {return}
		
		audioPlayerView.setPlayerLeftLabel(currentTime: audio)
        audioPlayerView.setPlayerRightLabel(audioDuration: duration)
    }
}

// MARK: Constraints
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
    
    func setupRecordButtonViewConstraints() {
        NSLayoutConstraint.activate([
            recordButtonView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            recordButtonView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.25),
            recordButtonView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.15),
            recordButtonView.topAnchor.constraint(equalTo: self.audioPlayerView.bottomAnchor, constant: 28)
        ])
    }
}

// MARK: Audio Record and Play delegates
@available(iOS 13.0, *)
extension AudioViewController: AudioRecordDelegate {
    
    func didTapRecordButton() {
        if audioManager.audioRecorder == nil {
            audioManager.startRecording()
        } else {
            audioManager.finishRecording(success: true)
        }
        setRecordButtonState()
    }
    
    func didFinishRecord() {
        audioTableView.reloadData()
        recordButtonView.recordButton.imageView?.layer.removeAllAnimations()
        presentNewAudioController()
    }
    
    func didBeginRecord() {
        animateRecordingView()
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
        recordButtonView.setButtonInteractivity(false)
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
        
        recordButtonView.setButtonInteractivity(true)
    }
}
