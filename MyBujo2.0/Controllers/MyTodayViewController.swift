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
    
    var calendarView = CalendarView(with: .week)
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.isHidden = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        calendarView.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // Do any additional setup after loading the view.
    }
    
    func buildViewHierarchy() {
        view.addSubview(calendarView)
        view.addSubview(goalsView)
    }
       
    func setupConstraints() {
        constraintCalendar()
        NSLayoutConstraint.activate([
            goalsView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 16),
            goalsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            goalsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            goalsView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5)
        ])
    }
  
    func constraintCalendar(){
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            calendarView.heightAnchor.constraint(equalToConstant: 176)
            ])
    }

    func setupAdditionalConfigurantion() {
        self.view.backgroundColor = UIColor(named: "BlueBackground")
        
    }
}
