//
//  MyTodayViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 21/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class MyTodayViewController: UIViewController, ViewCode {
    var tableView = UITableView(frame: .zero, style: .grouped)
    var day =  Day(context: CoreDataManager.context) {
        didSet {
            tableView.reloadData()
        }
    }
    
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
        
        guard let result = CoreDataManager.fetch(entityClass: Day.self, predicate: EntityType.day(Date()).predicate)?.first as? Day else {
            
            day = Day(context: CoreDataManager.context)
            guard let dateIgnoringTime = Date().ignoringTime() else { return }
            day.date = dateIgnoringTime
            day.save()
            return
        }
        self.day = result
    }
    
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }

    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

    func setupAdditionalConfigurantion() {
        self.view.backgroundColor = UIColor(named: "BlueBackground")
        tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: CalendarTableViewCell.reuseIdentifier)
        tableView.register(GoalsTableViewCell.self, forCellReuseIdentifier: GoalsTableViewCell.reuseIdentifier)
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
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
            guard let goals = day.goals?.array as? [Goal] else { return GoalsTableViewCell() }
            goalsCell.setupCell(goals: goals)
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
            return 168
        case 1:
            return tableView.frame.size.height/3
        case 2:
            return 168
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = HeaderViewFactory.build(section: section) else { return nil}
        headerView.delegate = self
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HeaderViewFactory.getHeight(section: section)
    }
    
}

extension MyTodayViewController:TableViewHeaderViewDelegate {
    func addGoal() {
        guard let viewCont = splitViewController?.viewControllers[1] else { return }
        viewCont.definesPresentationContext = true
        
        let newGoalViewController = NewGoalViewController()
        newGoalViewController.day = day
        newGoalViewController.delegate = self
        newGoalViewController.modalPresentationStyle = .overCurrentContext
        viewCont.present(newGoalViewController, animated: true, completion: nil)
    }
}

extension MyTodayViewController: MediaCollectionViewDelegate {
    func pushViewController(viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
}

extension MyTodayViewController: CalendarTableViewCellDelegate {
    
    /// Solve Later
    func didSelectDate(date: Date) {
        //do something

        let result = CoreDataManager.fetch(entityClass: Day.self,predicate: EntityType.day(date).predicate)
        guard let day = result?.first as? Day else {
            self.day = Day(context: CoreDataManager.context)
            guard let dateIgnoringTime = date.ignoringTime() else { return }
            self.day.date = dateIgnoringTime
            self.day.save()
            return
        }
        self.day = day
        
    }
}

extension MyTodayViewController: NewGoalViewControllerDelegate{
    func didDismissWithDescript() {
        tableView.reloadData()
    }
    
    func didDismissWithoutDescript() {
        //
    }
}
