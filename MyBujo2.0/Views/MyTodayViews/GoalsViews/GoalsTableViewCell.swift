//
//  GoalsTableViewCell.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 26/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//
import UIKit

class GoalsTableViewCell: UITableViewCell, ViewCode {
    static let reuseIdentifier = "GoalsTableViewCellIdentifier"
    let shadowView = ShadowView(frame: .zero)
    
    var lastNumberOfGoals = 0
    
    var day: Day?
    
    var goals: [Goal] = [] {
        didSet {
            if lastNumberOfGoals == goals.count - 1 {
                tableView.insertRows(at: [IndexPath(row: goals.count - 1, section: 0)], with: .automatic)
                if tableView.numberOfRows(inSection: 0) != 0 {
                    tableView.scrollToRow(at: IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0), at: .bottom, animated: true)
                }
            } else {
                tableView.reloadData()
            }
            
            lastNumberOfGoals = goals.count
        }
    }
    
    let tableView: UITableView = {
        let tbView = UITableView()
        tbView.translatesAutoresizingMaskIntoConstraints = false
        tbView.separatorStyle = .none
        return tbView
    }()
    
    func buildViewHierarchy() {
        contentView.addSubview(shadowView)
        contentView.addSubview(tableView)
    }
    
    func setupConstraints() {
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        
    }
    
    func setupAdditionalConfigurantion() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GoalTableViewCell.self, forCellReuseIdentifier: GoalTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 16
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    func setupCell(goals: [Goal], day: Day) {
        self.goals = goals
        self.day = day
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        setupView()
        
        
    }
}

extension GoalsTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoalTableViewCell.reuseIdentifier, for: indexPath) as? GoalTableViewCell else { return GoalTableViewCell() }
        cell.setupCell(goal: goals[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goals[indexPath.row].completed = !goals[indexPath.row].completed
        goals[indexPath.row].save()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let goal = goals[indexPath.row]
            guard let d = day else { return }
            d.removeFromGoals(goal)
            d.save()
            goals.remove(at: indexPath.row)
            
            tableView.reloadData()
        }
    }
    
}
