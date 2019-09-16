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
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        self.titleLabel = TitleLabel(title: title)
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
        return label
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNextLTPro-Regular", size: 10)
        return label
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPink
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
    
    let trashButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        return button
    }()
    
}

extension AudioPlayer: ViewCode {
    
    func buildViewHierarchy() {
        addSubviews([titleLabel, progressBar, leftLabel, rightLabel, playButton, advance15SecondsButton, back15SecondsButton, trashButton])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            
        ])
    }
    
    func setupAdditionalConfigurantion() {
        // there is no additionalConfiguration
    }
    
    
}
