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
        
    }
    
    func setupLogoImageViewConstraints() {
        
    }
    
}
