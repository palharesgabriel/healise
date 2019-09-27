//
//  AudioPlayer.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 16/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

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
        titleLabel.textColor = .white
        setupView()
    }
    
    let progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.trackTintColor = .yellow
        progressBar.progressTintColor = .purple
        return progressBar
    }()
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNextLTPro-Regular", size: 10)
        label.text = "-- : --"
        return label
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNextLTPro-Regular", size: 10)
        label.textAlignment = .right
        label.text = "-- : --"
        return label
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPink
        button.setTitle("Play", for: .normal)
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
            playButton.setTitle("Pause", for: .normal)
        } else {
            playButton.setTitle("Play", for: .normal)
        }
    }
    
    func setPlayerFlag(isPlaying: Bool) {
        self.isPlaying = isPlaying
    }
    
    func setTitleLabelText(audioName: String) {
        titleLabel.text = audioName
    }
    
    func setPlayerRightLabel(audioDuration: TimeInterval) {
        let fullPartDuration = Int(audioDuration)
        rightLabel.text = "-\(fullPartDuration)"
        
    }
    
    func setPlayerLeftLabel(currentTime: TimeInterval) {
        let fullPartCurrentTime = Int(currentTime)
        leftLabel.text = String(fullPartCurrentTime)
    }
        
}

extension AudioPlayer: ViewCode {
    
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
            progressBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
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
