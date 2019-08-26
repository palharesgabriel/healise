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

extension UIButton {
    convenience init(title: String) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
    }
}


class MasterViewController: UIViewController, ViewCode {
    
    let monthLabel = UILabel(text: "Tuesday", font: "Avenir Next", fontSize: 30, textColor: UIColor(named:"TitleColor")!)
    let dayLabel = UILabel(text: "13/08", font: "Avenir Next", fontSize: 60, textColor: UIColor(named:"TitleColor")!)
    let yearLabel = UILabel(text: "2019", font: "Avenir Next", fontSize: 30, textColor:  UIColor(named:"TitleColor")!)

    let myJourneyButton = UIButton(title: "🏠 My Journey")
    let myTodayButton = UIButton(title: "📅 My Today")
    let supportButton = UIButton(title: "⛑ Support")
    let settingsButton = UIButton(title: "⚙️ Settings")
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let contentView: UIView = {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
   }()

        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupView()
        myJourneyButton.setTitleColor(UIColor(named:"TitleColor")!, for: .normal)
        myTodayButton.setTitleColor(UIColor(named:"TitleColor")!, for: .normal)
        supportButton.setTitleColor(UIColor(named:"TitleColor")!, for: .normal)
        settingsButton.setTitleColor(UIColor(named:"TitleColor")!, for: .normal)
        myTodayButton.addTarget(self, action: #selector(didShowMyTodayViewController(_:)), for: .touchDown)
        myJourneyButton.addTarget(self, action: #selector(didShowMyJourneyViewController(_:)), for: .touchDown)

    }
    
    
    func buildViewHierarchy() {
        view.addSubview(monthLabel)
        view.addSubview(dayLabel)
        view.addSubview(yearLabel)
        view.addSubview(myTodayButton)
        view.addSubview(myJourneyButton)
        view.addSubview(supportButton)
        view.addSubview(settingsButton)
    }
    
    func setupConstraints() {
     
        
        NSLayoutConstraint.activate([
            
            monthLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            monthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            dayLabel.topAnchor.constraint(equalTo: monthLabel.bottomAnchor , constant: 0),
            dayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            yearLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 0),
            yearLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            myJourneyButton.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 32),
            myJourneyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            myTodayButton.topAnchor.constraint(equalTo: myJourneyButton.bottomAnchor, constant: 8),
            myTodayButton.leadingAnchor.constraint(equalTo: myJourneyButton.leadingAnchor),
            myTodayButton.widthAnchor.constraint(equalTo: myJourneyButton.widthAnchor),
            
            supportButton.topAnchor.constraint(equalTo: myTodayButton.bottomAnchor, constant: 8),
            supportButton.leadingAnchor.constraint(equalTo: myTodayButton.leadingAnchor),
            supportButton.widthAnchor.constraint(equalTo: myTodayButton.widthAnchor),

            settingsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            settingsButton.leadingAnchor.constraint(equalTo: supportButton.leadingAnchor),
            settingsButton.widthAnchor.constraint(equalTo: supportButton.widthAnchor),
        ])
    }
    
    func setupAdditionalConfigurantion() {
        view.backgroundColor = UIColor(named: "BlueBackground")
    }
    
    @objc func didShowMyJourneyViewController(_ sender: UIButton) {
        print(sender)
        let myJourneyViewController = MyJourneyViewController()
        self.splitViewController?.showDetailViewController(myJourneyViewController, sender: nil)

    }
    
    @objc func didShowMyTodayViewController(_ sender: UIButton) {
        self.splitViewController?.preferredDisplayMode = .automatic
        
        let myTodayViewController = MyTodayViewController()
        let navigationController = UINavigationController(rootViewController: myTodayViewController)
        navigationController.navigationBar.isHidden = true
        self.splitViewController?.showDetailViewController(navigationController, sender: nil)
    }
}
