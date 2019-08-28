//
//  GoalsTableViewCell.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 26/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//
import UIKit

class GoalsTableViewCell: UITableViewCell, ViewCode {
    
    let shadowView = ShadowView(frame: .zero)
    
    let goalsTableView: UITableView = {
        let tbView = UITableView()
        tbView.translatesAutoresizingMaskIntoConstraints = false
        tbView.separatorStyle = .none
        return tbView
    }()
    
    func buildViewHierarchy() {
        contentView.addSubview(shadowView)
        contentView.addSubview(goalsTableView)
    }
    
    func setupConstraints() {
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            ])
        
        goalsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goalsTableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            goalsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            goalsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            goalsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        
    }
    
    func setupAdditionalConfigurantion() {
        goalsTableView.delegate = self
        goalsTableView.dataSource = self
        goalsTableView.register(GoalTableViewCell.self, forCellReuseIdentifier: GoalTableViewCell.reuseIdentifier)
        goalsTableView.backgroundColor = .clear
        goalsTableView.showsVerticalScrollIndicator = false
        
        goalsTableView.clipsToBounds = true
        goalsTableView.layer.cornerRadius = 16
        goalsTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
    }
    
    func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        setupView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension GoalsTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoalTableViewCell.reuseIdentifier, for: indexPath) as? GoalTableViewCell else {
            return GoalTableViewCell()
        }
        
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
