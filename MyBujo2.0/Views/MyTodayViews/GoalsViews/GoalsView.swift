//
//  GoalsView.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 26/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class GoalsView: UIView, ViewCode, Shadow {
    
    let goalsTableView: UITableView = {
        let tbView = UITableView()
        tbView.translatesAutoresizingMaskIntoConstraints = false
        tbView.separatorStyle = .none
        return tbView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addShadow()
        goalsTableView.delegate = self
        goalsTableView.dataSource = self
        goalsTableView.register(GoalTableViewCell.self, forCellReuseIdentifier: GoalTableViewCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(goalsTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            goalsTableView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            goalsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            goalsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            goalsTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        backgroundColor = .white
        self.goalsTableView.backgroundColor = .clear
        self.goalsTableView.showsVerticalScrollIndicator = false
    }
}

extension GoalsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GoalTableViewCell.reuseIdentifier, for: indexPath) as! GoalTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let oldIndex = tableView.indexPathForSelectedRow {
            let cell = tableView.cellForRow(at: oldIndex)
            cell?.accessoryType = .none
            cell?.selectionStyle = .none
            cell?.selectedBackgroundView = UIView()
            
        }
        let cell = tableView.cellForRow(at: indexPath)
        cell!.accessoryType = .checkmark
        cell?.selectionStyle = .none
        cell?.selectedBackgroundView = UIView()
        
        return indexPath
    }
    
}
