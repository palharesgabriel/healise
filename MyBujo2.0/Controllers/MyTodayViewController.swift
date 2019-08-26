//
//  MyTodayViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 21/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class MyTodayViewController: UIViewController, ViewCode {
   
    let goalsView = GoalsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // Do any additional setup after loading the view.
    }
    
    func buildViewHierarchy() {
        view.addSubview(goalsView)
    }
       
    func setupConstraints() {
        NSLayoutConstraint.activate([
            goalsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            goalsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            goalsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            goalsView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5)
        ])
    }
       
    func setupAdditionalConfigurantion() {
        self.view.backgroundColor = .white
        
    }
}


