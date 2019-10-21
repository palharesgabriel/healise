//
//  WelcomeViewController.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 16/10/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let pageControllView = PageControlView()
    let welcomeLabel = TitleLabel(title: "Bem vindo ao ")
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = pageControllView
        self.view.addSubviews([welcomeLabel, logoImageView])
        setupLabelConstraints()
        setupLogoImageViewConstraints()
    }

}


extension WelcomeViewController {
    
    func setupLabelConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 24),
            welcomeLabel.bottomAnchor.constraint(equalTo: logoImageView.topAnchor, constant: 64),
            welcomeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            welcomeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24)
        ])
    }
    
    func setupLogoImageViewConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: self.pageControllView.pageControl.topAnchor, constant: 32),
            logoImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            logoImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24)
        ])
    }
    
}
