//
//  AudioPlayer.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 16/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class AudioPlayer: UIView {
    
    var titleLabel: TitleLabel!
    var playDelegate: AudioPlayerDelegate?
    var isPlaying: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero)
        titleLabel = TitleLabel(title: "Audio")
        setupView()
        addShadow(view: self)
    }
    
    let progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.trackTintColor = .gray
        progressBar.progressTintColor = UIColor(named: "SelectionColor")
        return progressBar
    }()
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNextLTPro-Regular", size: 10)
        label.text = "-- : --"
        label.textColor = UIColor(named: "TitleColor")
        return label
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNextLTPro-Regular", size: 10)
        label.textAlignment = .right
        label.text = "-- : --"
        label.textColor = UIColor(named: "TitleColor")
        return label
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        return button
    }()
    
    let fastForwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(fastForwardButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let fastBackwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(fastBackwardButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    @objc func playTapped() {
        if isPlaying {
            playDelegate?.didTapPause()
        } else {
            playDelegate?.didBeginPlay()
        }
        setPlayButtonState()
    }
    
    @objc func fastForwardButtonTapped() {
        playDelegate?.didTapFastForwardButton()
    }
    
    @objc func fastBackwardButtonTapped() {
        playDelegate?.didTapFastBackwardButton()
    }
    
    func setPlayButtonState() {
        if isPlaying {
            playButton.setImage(UIImage(systemName: "playpause.fill"), for: .normal)
        } else {
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    func setPlayerFlag(isPlaying: Bool) {
        self.isPlaying = isPlaying
    }
    
    func setTitleLabelText(audioName: String) {
        titleLabel.text = audioName
    }
    
    func setPlayerRightLabel(audioDuration: TimeInterval) {
        var secDuration = Int(audioDuration.truncatingRemainder(dividingBy: 60))
        var minDuration = Int((audioDuration/60).truncatingRemainder(dividingBy: 60))
        
        minDuration = minDuration == 60 ? 0 : minDuration
        secDuration = secDuration == 60 ? 0 : secDuration
        
        rightLabel.text = "-\(minDuration):\(secDuration)"
        
    }
    
    func setPlayerLeftLabel(currentTime: TimeInterval) {
        var secCurrentTime = Int(currentTime.truncatingRemainder(dividingBy: 60))
        var minCurrentTime = Int((currentTime/60).truncatingRemainder(dividingBy: 60))
        
        minCurrentTime = minCurrentTime == 60 ? 0 : minCurrentTime
        secCurrentTime = secCurrentTime == 60 ? 0 :secCurrentTime
        
        leftLabel.text = "\(minCurrentTime):\(secCurrentTime)"
    }
        
}

@available(iOS 13.0, *)
extension AudioPlayer: ViewCode, Shadow {
    
    func buildViewHierarchy() {
        addSubviews([titleLabel, progressBar, leftLabel, rightLabel, playButton, fastForwardButton, fastBackwardButton])
    }
    
    func setupConstraints() {
        setupTitleViewConstraints()
        setupProgressBarConstraints()
        setupLeftLabelConstraints()
        setupRightLabelConstraints()
        setupPlayButtonConstraints()
        setupAdvance15SecondsButtonConstraints()
        setupBack15SecondsButtonConstraints()
    }
    
    func setupAdditionalConfigurantion() {
        self.backgroundColor = .purple
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

@available(iOS 13.0, *)
extension AudioPlayer {
    
    func setupTitleViewConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func setupProgressBarConstraints() {
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 36),
            progressBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            progressBar.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    func setupLeftLabelConstraints() {
        NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            leftLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 8),
            leftLabel.widthAnchor.constraint(equalToConstant: 64),
            leftLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func setupRightLabelConstraints() {
        NSLayoutConstraint.activate([
            rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            rightLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 8),
            rightLabel.widthAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    func setupPlayButtonConstraints() {
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 24),
            playButton.centerXAnchor.constraint(equalTo: progressBar.centerXAnchor),
            playButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15),
            playButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3)
        ])
    }
    
    func setupAdvance15SecondsButtonConstraints() {
        NSLayoutConstraint.activate([
            fastForwardButton.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 24),
            fastForwardButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 16),
            fastForwardButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            fastForwardButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])
    }
    
    func setupBack15SecondsButtonConstraints() {
        NSLayoutConstraint.activate([
            fastBackwardButton.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 24),
            fastBackwardButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -16),
            fastBackwardButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            fastBackwardButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])
    }
    
}
