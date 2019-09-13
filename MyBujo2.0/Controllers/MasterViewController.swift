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
    let nameLabel = UILabel(text: "Lucas,", font: "Avenir Next", fontSize: 24, textColor: UIColor(named:"SelectionColor")!)
    let dayStatusLabel = UILabel(text: "Good morning.", font: "Avenir Next", fontSize: 24, textColor:  UIColor(named:"SelectionColor")!)
    let myTodayButton = NavigationButton(title: "      Daily",icon: "person", idColor: 0)
    let myJourneyButton = NavigationButton(title: "        Journey",icon: "calendar", idColor: 1)
    let supportButton = NavigationButton(title: "      Support",icon: "person.2", idColor: 2)
    let settingsButton = NavigationButton(title: "      Settings",icon: "gear", idColor: 3)
    var viewControllers: [UINavigationController] = []
    
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        myTodayButton.addTarget(self, action: #selector(didClickMyTodayButton(_:)), for: .touchDown)
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
            dayStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            
            myTodayButton.topAnchor.constraint(equalTo: dayStatusLabel.bottomAnchor, constant: 112),
            myTodayButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 0),
            myTodayButton.widthAnchor.constraint(equalTo:self.view.widthAnchor,constant: -16),
            myTodayButton.heightAnchor.constraint(equalToConstant: 45),
            
            myJourneyButton.topAnchor.constraint(equalTo: myTodayButton.bottomAnchor, constant: 32),
            myJourneyButton.centerXAnchor.constraint(equalTo: myTodayButton.centerXAnchor,constant: 0),
            myJourneyButton.widthAnchor.constraint(equalTo: self.view.widthAnchor,constant: -16),
            myJourneyButton.heightAnchor.constraint(equalToConstant: 45),
            
            supportButton.topAnchor.constraint(equalTo: myJourneyButton.bottomAnchor, constant: 32),
            supportButton.centerXAnchor.constraint(equalTo: myTodayButton.centerXAnchor,constant: 0),
            supportButton.widthAnchor.constraint(equalTo: self.view.widthAnchor,constant: -16),
            supportButton.heightAnchor.constraint(equalToConstant: 45),
            
            
            settingsButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32),
            settingsButton.centerXAnchor.constraint(equalTo: myTodayButton.centerXAnchor),
            settingsButton.widthAnchor.constraint(equalTo: self.view.widthAnchor,constant: -16),
            settingsButton.heightAnchor.constraint(equalToConstant: 45)
            ])
    }
    func setupAdditionalConfigurantion() {
        view.backgroundColor = UIColor(named: "BlueBackground")
        updateButtons(sender: myTodayButton)
    }
    func updateButtons(sender: NavigationButton) {
        NavigationButton.selectedId = sender.identifier
        
        myTodayButton.changeColors()
        myJourneyButton.changeColors()
        supportButton.changeColors()
        settingsButton.changeColors()
    }
    
    
    
    // MARK: Action Buttons
    @objc func didShowMyJourneyViewController(_ sender: NavigationButton) {
        updateButtons(sender: sender)
        self.splitViewController?.preferredDisplayMode = .automatic
        let navigationController = viewControllers[1]
        self.splitViewController?.showDetailViewController(navigationController, sender: nil)
    }
    @objc func didClickMyTodayButton(_ sender: NavigationButton) {
        updateButtons(sender: sender)
        
        let navigationController = viewControllers[0]
        self.splitViewController?.showDetailViewController(navigationController, sender: nil)
    }
}
