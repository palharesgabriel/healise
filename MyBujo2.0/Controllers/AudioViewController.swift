//
//  AudioViewController.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 16/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation

class AudioViewController: MediaViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.backgroundColor = .red
        self.view.backgroundColor = .blue
        
        let audioPlayer = AudioPlayer(title: "Palhares")
        self.view.addSubview(audioPlayer)
        audioPlayer.translatesAutoresizingMaskIntoConstraints = false
        
        audioPlayer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        audioPlayer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        audioPlayer.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        audioPlayer.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
}

extension AudioViewController: ViewCode {
    
    func buildViewHierarchy() {
        //
    }
    
    func setupConstraints() {
        //
    }
    
    func setupAdditionalConfigurantion() {
        //
    }
    
}
