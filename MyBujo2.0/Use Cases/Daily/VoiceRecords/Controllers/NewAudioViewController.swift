//
//  NewAudioViewController.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 27/11/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class NewAudioViewController: UIViewController {
    
    let newAudioView = NewAudioView()
    var audioName = String()
    weak var delegate: SaveAudioName?
    
    
    override func viewDidLoad() {
        self.view = newAudioView
        newAudioView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.didSaveAudioName(audioName)
    }
    
}

extension NewAudioViewController: NewAudioDelegate {
    
    func didEnterAudioName(_ name: String) {
        audioName = name
        dismiss(animated: true, completion: nil)
    }
    
}
