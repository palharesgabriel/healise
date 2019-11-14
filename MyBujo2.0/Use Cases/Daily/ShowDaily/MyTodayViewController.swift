//
//  MyTodayViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 21/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class MyTodayViewController: UIViewController, ViewCode {
    
    lazy var addFeelingButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Add Feeling", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addFeeling))
        return button
    }()
    
    // MARK: Properties
    var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    

    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableView.reloadData()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMM"
        self.title = "\(dateFormatter.string(from: CalendarManager.shared.selectedDay.date?.ignoringTime() ?? Date()))"
        
    }
    
    
    // MARK: Override Functions
    
    // MARK: Functions
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
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
        
        navigationItem.setRightBarButton(addFeelingButton, animated: false)
    }
    
    @objc func addFeeling() {
        let controller = NewFeelingViewController()
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
}

extension MyTodayViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        switch indexPath.section {
        case 0:
            guard let goalsCell = tableView.dequeueReusableCell(withIdentifier: GoalsTableViewCell.reuseIdentifier, for: indexPath) as? GoalsTableViewCell else { return UITableViewCell() }
            let day = CalendarManager.shared.selectedDay
            guard let goals = day.goals?.array as? [Goal] else { return UITableViewCell() }
            goalsCell.setupCell(goals: goals, day: day)
            return goalsCell
        case 1:
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
            return tableView.frame.size.height/3
        case 1:
            return tableView.frame.size.height/3
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
