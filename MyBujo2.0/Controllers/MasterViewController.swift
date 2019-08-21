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
    
    let monthLabel = UILabel(text: "Tuesday", font: "Avenir Next", fontSize: 30, textColor: .init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1))
    let dayLabel = UILabel(text: "13/08", font: "Avenir Next", fontSize: 60, textColor: .white)
    let yearLabel = UILabel(text: "2019", font: "Avenir Next", fontSize: 30, textColor:  .init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1))

    let trackingButton = UIButton(title: "🏠 My Journey")
    let dailyButton = UIButton(title: "📅 My Today")
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
        // Do any additional setup after loading the view.
    }
    
    
    func buildViewHierarchy() {
        view.addSubview(monthLabel)
        view.addSubview(dayLabel)
        view.addSubview(yearLabel)
        view.addSubview(trackingButton)
        view.addSubview(dailyButton)
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

            trackingButton.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 32),
            trackingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            dailyButton.topAnchor.constraint(equalTo: trackingButton.bottomAnchor, constant: 8),
            dailyButton.leadingAnchor.constraint(equalTo: trackingButton.leadingAnchor),
            dailyButton.widthAnchor.constraint(equalTo: trackingButton.widthAnchor),
            
            supportButton.topAnchor.constraint(equalTo: dailyButton.bottomAnchor, constant: 8),
            supportButton.leadingAnchor.constraint(equalTo: dailyButton.leadingAnchor),
            supportButton.widthAnchor.constraint(equalTo: dailyButton.widthAnchor),

            settingsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            settingsButton.leadingAnchor.constraint(equalTo: supportButton.leadingAnchor),
            settingsButton.widthAnchor.constraint(equalTo: supportButton.widthAnchor),
        ])
    }
    
    func setupAdditionalConfigurantion() {
                 view.backgroundColor = .init(red: 83/255, green: 112/255, blue: 237/255, alpha: 1)
        
    }
}
