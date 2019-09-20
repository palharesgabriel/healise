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
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BlueBackground")
        setupView()
    }
    
    
    // MARK: Override Functions
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.isHidden = true
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CalendarTableViewCell else { return }
        cell.calendarView.selectDates([CalendarManager.shared.selectedDay.date!], triggerSelectionDelegate: true, keepSelectionIfMultiSelectionAllowed: false)
    }
    
    
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
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    func setupAdditionalConfigurantion() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension MyJourneyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "calendarCell") as? CalendarTableViewCell else { return UITableViewCell()}
            cell.delegate = self
            cell.setupCell(calendarType: .month, date: Date())
            return cell
        case 1:
            guard let cellCollection = tableView.dequeueReusableCell(withIdentifier: "cardsCell") as? CollectionTableViewCell else {return UITableViewCell() }
            return cellCollection
        default:
            return UITableViewCell()
        }

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 344
        case 1:
            return 344
        default:
            return 0
        }
    }
}

extension MyJourneyViewController: CalendarTableViewCellDelegate {
    func didSelectDate(date: Date) {
        //
    }
    
    func shouldShowAddFeelingModal() {
        //
    }
}
