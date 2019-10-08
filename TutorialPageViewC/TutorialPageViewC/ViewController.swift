//
//  ViewController.swift
//  TutorialPageViewC
//
//  Created by Rennan Rebouças on 29/09/19.
//  Copyright © 2019 Rennan Rebouças. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let starTutorialBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        starTutorialBtn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(starTutorialBtn)
        starTutorialBtn.backgroundColor = .red
        NSLayoutConstraint.activate([
            starTutorialBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            starTutorialBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            starTutorialBtn.widthAnchor.constraint(equalToConstant: 200),
            starTutorialBtn.heightAnchor.constraint(equalToConstant: 100)
            ])
        self.view.backgroundColor = .lightText
    }


}

