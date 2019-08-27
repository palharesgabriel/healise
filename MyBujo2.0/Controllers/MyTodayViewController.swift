//
//  MyTodayViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 21/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class MyTodayViewController: UIViewController, ViewCode {
    var tableView = UITableView(frame: .zero)
    let goalsView = GoalsView()
    let calendarView = CalendarView(with: .week)
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }

    func setupConstraints() {
        constraintTableView()
    }

    func setupAdditionalConfigurantion() {
        self.view.backgroundColor = UIColor(named: "BlueBackground")
        tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: "calendarCell")
        tableView.register(GoalsTableViewCell.self, forCellReuseIdentifier: "goalsCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
    func constraintTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension MyTodayViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        switch indexPath.section {
        case 0:
            guard let calendarCell = tableView.dequeueReusableCell(withIdentifier: "calendarCell", for: indexPath) as? CalendarTableViewCell else { return UITableViewCell()}
            
            calendarCell.setupCell(calendarType: .week)
            return calendarCell
        case 1:
            guard let goalsCell = tableView.dequeueReusableCell(withIdentifier: "goalsCell", for: indexPath) as? GoalsTableViewCell else { return UITableViewCell() }
            goalsCell.setupCell()
            return goalsCell
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 176
        case 1:
            guard let height = tableView.cellForRow(at: indexPath)?.frame.height else {return 400}
            return height
        default:
            return 0
        }
    }
    
}
