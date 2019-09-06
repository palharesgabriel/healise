//
//  MasterViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 20/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, ViewCode {
    
    // MARK: Properties

    let nameLabel = UILabel(text: "Lucas,", font: "Avenir Next", fontSize: 24, textColor: UIColor(named:"StartColor")!)
    let dayStatusLabel = UILabel(text: "Good morning.", font: "Avenir Next", fontSize: 24, textColor:  UIColor(named:"StartColor")!)
    let myJourneyButton = UIButton(title: "   You Journey",icon: "journey")
    let myTodayButton = UIButton(title: " Today",icon: "today")
    let supportButton = UIButton(title: " Support",icon: "support")
    let settingsButton = UIButton(title: " Settings",icon: "settings")
    var viewControllers: [UINavigationController] = []
    
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        myTodayButton.addTarget(self, action: #selector(didShowMyTodayViewController(_:)), for: .touchDown)
        myJourneyButton.addTarget(self, action: #selector(didShowMyJourneyViewController(_:)), for: .touchDown)
    }
    
    // MARK: Functions
    func buildViewHierarchy() {
        view.addSubviews([nameLabel, dayStatusLabel, myTodayButton,
                          myJourneyButton, supportButton, settingsButton ])
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 28),

            
            dayStatusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
            dayStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dayStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 4),
            
            myTodayButton.topAnchor.constraint(equalTo: dayStatusLabel.bottomAnchor, constant: 112),
            myTodayButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 30),
            myTodayButton.widthAnchor.constraint(equalToConstant: 150),
            
            myJourneyButton.topAnchor.constraint(equalTo: myTodayButton.bottomAnchor, constant: 32),
            myJourneyButton.centerXAnchor.constraint(equalTo: myTodayButton.centerXAnchor,constant: 0),
            myJourneyButton.widthAnchor.constraint(equalToConstant: 150),
            
            supportButton.topAnchor.constraint(equalTo: myJourneyButton.bottomAnchor, constant: 32),
            supportButton.centerXAnchor.constraint(equalTo: myTodayButton.centerXAnchor,constant: 0),
            supportButton.widthAnchor.constraint(equalToConstant: 150),
            
            
            settingsButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32),
            settingsButton.centerXAnchor.constraint(equalTo: myTodayButton.centerXAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 150)
            ])
    }
    func setupAdditionalConfigurantion() {
        view.backgroundColor = UIColor(named: "BlueBackground")
    }
    
    // MARK: Action Buttons
    @objc func didShowMyJourneyViewController(_ sender: UIButton) {
        self.splitViewController?.preferredDisplayMode = .automatic
        let navigationController = viewControllers[1]
        self.splitViewController?.showDetailViewController(navigationController, sender: nil)
    }
    @objc func didShowMyTodayViewController(_ sender: UIButton) {
        let navigationController = viewControllers[0]
        self.splitViewController?.showDetailViewController(navigationController, sender: nil)
        
    }
}
