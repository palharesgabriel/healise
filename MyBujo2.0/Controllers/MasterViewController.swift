//
//  MasterViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 20/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: String, fontSize: CGFloat, textColor: UIColor) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.font = UIFont(name: font, size: fontSize)
        self.textAlignment = .center
        self.textColor = textColor
        self.adjustsFontSizeToFitWidth = true
    }
}

class MasterViewController: UIViewController, ViewCode {
    
    let monthLabel = UILabel(text: "Lucas,", font: "Avenir Next", fontSize: 60, textColor: UIColor(named:"StartColor")!)
    let dayLabel = UILabel(text: "Good", font: "Avenir Next", fontSize: 30, textColor: UIColor(named:"StartColor")!)
    let yearLabel = UILabel(text: "morning.", font: "Avenir Next", fontSize: 30, textColor:  UIColor(named:"StartColor")!)

    let myJourneyButton = UIButton(title: "🏠 You Journey")
    let myTodayButton = UIButton(title: "📅 Today")
    let supportButton = UIButton(title: "⛑ Support")
    let settingsButton = UIButton(title: "⚙️ Settings")
    
    var viewControllers: [UINavigationController] = []
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
       
        myTodayButton.setTitleColor(UIColor(named:"TitleColor")!, for: .normal)
        myJourneyButton.setTitleColor(UIColor(named:"TitleColor")!, for: .normal)
        supportButton.setTitleColor(UIColor(named:"TitleColor")!, for: .normal)
        settingsButton.setTitleColor(UIColor(named:"TitleColor")!, for: .normal)
        myTodayButton.addTarget(self, action: #selector(didShowMyTodayViewController(_:)), for: .touchDown)
        myJourneyButton.addTarget(self, action: #selector(didShowMyJourneyViewController(_:)), for: .touchDown)
    }
    
    
    func buildViewHierarchy() {
        view.addSubviews([monthLabel, dayLabel, yearLabel, myTodayButton,
                          myJourneyButton, supportButton, settingsButton ])
    }
    
    func setupConstraints() {
     
        
        NSLayoutConstraint.activate([
            
            monthLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            monthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            dayLabel.topAnchor.constraint(equalTo: monthLabel.bottomAnchor , constant: 0),
            dayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            dayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 4),
            

            yearLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 0),
            yearLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            yearLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 4),
            
            myTodayButton.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 64),
            myTodayButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            myTodayButton.widthAnchor.constraint(equalToConstant: 150),
            
            myJourneyButton.topAnchor.constraint(equalTo: myTodayButton.bottomAnchor, constant: 16),
            myJourneyButton.centerXAnchor.constraint(equalTo: myTodayButton.centerXAnchor),
            
            myJourneyButton.widthAnchor.constraint(equalToConstant: 150),
            
            supportButton.topAnchor.constraint(equalTo: myJourneyButton.bottomAnchor, constant: 16),
            supportButton.centerXAnchor.constraint(equalTo: myTodayButton.centerXAnchor),
            supportButton.widthAnchor.constraint(equalToConstant: 150),
            
            
            settingsButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32),
            settingsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 150) 
        ])
    }
    
    func setupAdditionalConfigurantion() {
        view.backgroundColor = UIColor(named: "BlueBackground")
    }
    
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
