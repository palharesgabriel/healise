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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AudioPlayer(title: "Palhares")
        self.view.backgroundColor = .blue
        setupView()
    }
    
}

extension AudioViewController: ViewCode {
    
    func buildViewHierarchy() {
        self.contentView.addSubviews([audioTableView, audioPlayer])
    }
    
    func setupConstraints() {
        setupTableViewConstraints()
        setupAudioPlayerConstraints()
    }
    
    func setupAdditionalConfigurantion() {
        audioTableView.dataSource = self
    }
    
}

extension AudioViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = audioTableView.dequeueReusableCell(withIdentifier: "AudioCell")
        cell?.textLabel?.text = "Palhariel"
        return cell ?? UITableViewCell()
    }
    
}

extension AudioViewController {
    
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            audioTableView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            audioTableView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.95),
            audioTableView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5),
            audioTableView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16)
        ])
    }
    
    func setupAudioPlayerConstraints() {
        NSLayoutConstraint.activate([
            audioPlayer.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            audioPlayer.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.95),
            audioPlayer.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.3),
            audioPlayer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
    }
    
}
