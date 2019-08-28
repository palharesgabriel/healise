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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.isHidden = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let calendarView  = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CalendarTableViewCell else { return }
        calendarView.viewWillTransition(to: .zero, with: coordinator)
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
        tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: CalendarTableViewHeaderView.reuseIdentifier)
        tableView.register(GoalsTableViewCell.self, forCellReuseIdentifier: GoalsTableViewHeaderView.reuseIdentifier)
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
    func constraintTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MyTodayViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        switch indexPath.section {
        case 0:
            guard let calendarCell = tableView.dequeueReusableCell(withIdentifier: CalendarTableViewHeaderView.reuseIdentifier, for: indexPath) as? CalendarTableViewCell else { return UITableViewCell()}
            
            calendarCell.setupCell(calendarType: .week)
            return calendarCell
        case 1:
            guard let goalsCell = tableView.dequeueReusableCell(withIdentifier: GoalsTableViewHeaderView.reuseIdentifier, for: indexPath) as? GoalsTableViewCell else { return UITableViewCell() }
            goalsCell.setupCell()
            return goalsCell
        case 2:
            guard let mediaCell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.reuseIdentifier) as? MediaTableViewCell else { return UITableViewCell() }
            mediaCell.setupCell()
            return mediaCell
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 168
        case 1:
            return tableView.frame.size.height/3
        case 2:
            return tableView.frame.size.height/3
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderViewFactory.build(section: section)
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HeaderViewFactory.getHeight(section: section)
    }
    
}
