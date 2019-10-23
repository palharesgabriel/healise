//
//  MyTodayViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 21/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class MyTodayViewController: UIViewController, ViewCode {
    
    // MARK: Properties
    var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    var day =  Day(context: CoreDataManager.context)

    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.day = CalendarManager.shared.currentDay
        CalendarManager.shared.selectedDay = self.day
        tableView.reloadData()
		self.title = "Daily"
    }
    
    
    // MARK: Override Functions
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor(named: "BlueBackground")
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let calendarView  = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CalendarTableViewCell else { return }
        calendarView.viewWillTransition(to: .zero, with: coordinator)
    }
    
    
    // MARK: Functions
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
    }
    func setupAdditionalConfigurantion() {
        self.view.backgroundColor = UIColor(named: "BlueBackground")
        
        tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: CalendarTableViewCell.reuseIdentifier)
        tableView.register(GoalsTableViewCell.self, forCellReuseIdentifier: GoalsTableViewCell.reuseIdentifier)
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.reuseIdentifier)
        tableView.register(CalendarTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: CalendarTableViewHeaderView.reuseIdentifier)
        tableView.register(GoalsTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: GoalsTableViewHeaderView.reuseIdentifier)
        tableView.register(MediaTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: MediaTableViewHeaderView.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
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
            guard let calendarCell = tableView.dequeueReusableCell(withIdentifier: CalendarTableViewCell.reuseIdentifier, for: indexPath) as? CalendarTableViewCell else { return UITableViewCell()}
            calendarCell.delegate = self
            calendarCell.setupCell(calendarType: .week, date: day.date!)
            return calendarCell
        case 1:
            guard let goalsCell = tableView.dequeueReusableCell(withIdentifier: GoalsTableViewCell.reuseIdentifier, for: indexPath) as? GoalsTableViewCell else { return UITableViewCell() }
            guard let goals = day.goals?.array as? [Goal] else { return UITableViewCell() }
            goalsCell.setupCell(goals: goals, day: day)
            return goalsCell
        case 2:
            guard let mediaCell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.reuseIdentifier) as? MediaTableViewCell else { return UITableViewCell() }
            mediaCell.delegate = self
            mediaCell.setupCell()
            return mediaCell
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 160
        case 1:
            return tableView.frame.size.height/3
        case 2:
            return 168
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerFactory = HeaderViewFactory(tableView: tableView, section: section)
        guard let headerView = headerFactory.build() else { return nil}
        headerView.delegate = self
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerFactory = HeaderViewFactory(tableView: tableView, section: section)
        return headerFactory.height()
    }
    
}
