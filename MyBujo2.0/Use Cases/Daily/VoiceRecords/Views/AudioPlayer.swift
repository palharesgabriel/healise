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
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        self.titleLabel = TitleLabel(title: title)
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
        label.text = "TESTE"
        return label
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNextLTPro-Regular", size: 10)
        label.text = "TESTE"
        return label
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        return button
    }()
    
    let advance15SecondsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        return button
    }()
    
    let back15SecondsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        return button
    }()
    
    
    @objc func playTapped() {
        self.playDelegate?.didBeginPlay()
        playButton.backgroundColor = .blue
    }
    
}

extension AudioPlayer: ViewCode {
    
    func buildViewHierarchy() {
        addSubviews([titleLabel, progressBar, leftLabel, rightLabel, playButton, advance15SecondsButton, back15SecondsButton])
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
            playButton.heightAnchor.constraint(equalToConstant: 72),
            playButton.centerXAnchor.constraint(equalTo: progressBar.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 72)
        ])
    }
    
    func setupAdvance15SecondsButtonConstraints() {
        NSLayoutConstraint.activate([
            advance15SecondsButton.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 24),
            advance15SecondsButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 16),
            advance15SecondsButton.widthAnchor.constraint(equalToConstant: 64),
            advance15SecondsButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    func setupBack15SecondsButtonConstraints() {
        NSLayoutConstraint.activate([
            back15SecondsButton.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 24),
            back15SecondsButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -16),
            back15SecondsButton.widthAnchor.constraint(equalToConstant: 64),
            back15SecondsButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
}
