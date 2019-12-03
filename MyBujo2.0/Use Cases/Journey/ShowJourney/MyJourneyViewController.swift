//
//  ViewController.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 19/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit
import JTAppleCalendar
class MyJourneyViewController: UIViewController, ViewCode {
    
    
    // MARK: Properties

    var day: Day!
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: "calendarCell")
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: "cardsCell")
        tableView.register(TableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blueBackground
        setupView()
		self.title = "Journey"
//		self.navigationController?.navigationBar.ite

    }
    override func viewWillAppear(_ animated: Bool) {
        guard var cell = tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? CalendarTableViewCell else { return }
        cell.calendarView.reloadData()
        guard let cell2 = tableView.cellForRow(at: IndexPath(item: 0, section: 1)) as? CollectionTableViewCell else { return }
        cell2.collectionView.reloadData()
        
        
    }
    
    
    // MARK: Override Functions
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let calendarCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CalendarTableViewCell else { return }
        calendarCell.viewWillTransition(to: size, with: coordinator)
    }
    
    
    // MARK: Functions
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    func setupAdditionalConfigurantion() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension MyJourneyViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "calendarCell") as? CalendarTableViewCell else { return UITableViewCell()}
            cell.delegate = self
            cell.setupCell(calendarType: .month, date: Date())
            return cell
        case 1:
            guard let cellCollection = tableView.dequeueReusableCell(withIdentifier: "cardsCell") as? CollectionTableViewCell else { return UITableViewCell() }
            return cellCollection
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? TableViewHeaderView else { return nil }
        cell.setupHeader(headerTitle: "Overview")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let colectionCell = cell as? CollectionTableViewCell {
            colectionCell.collectionView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 320
        case 1:
            return 340
        default:
            return 0
        }
    }
}

extension MyJourneyViewController: CalendarTableViewCellDelegate {
    func didScroll(direction: Direction) {
        guard let cell2 = tableView.cellForRow(at: IndexPath(item: 0, section: 1)) as? CollectionTableViewCell else { return }
        cell2.collectionView.reloadData()
    }
    
    func didSelectDate(date: Date) {
        CalendarManager.shared.selectedDay = CalendarManager.shared.getDay(date: date)
        navigationController?.pushViewController(MyTodayViewController(), animated: true)
    }
    
    func shouldShowAddFeelingModal() {
        
    }
}
