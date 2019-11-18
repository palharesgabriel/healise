//
//  GoalsTableViewCell.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 26/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class GoalTableViewCell: UITableViewCell, ViewCode {
    static let reuseIdentifier = "GoalTableViewCell"
    var goal: Goal!
    let goalDescription: UILabel = {
        let lbl = UILabel()
        lbl.text = "Teste"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "AvenirNext-Medium", size: 16)
        lbl.textColor = UIColor(named: "TitleColor")!
        return lbl
    }()
    
    let goalBullet: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 16, weight: .light)
        let view = UIImageView(image: UIImage(systemName: "circle", withConfiguration: configuration))
        view.tintColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let checkMarkView: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 16, weight: .light)
        let view = UIImageView(image: UIImage(systemName: "checkmark.circle.fill", withConfiguration: configuration))
        view.tintColor = UIColor(named: "SelectionColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    func setupCell(goal: Goal) {
        self.goal = goal
        goalDescription.text = goal.descript
        if goal.completed {
            self.addSubview(checkMarkView)
            checkMarkView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 14).isActive = true
            checkMarkView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
            goalDescription.textColor = UIColor(named: "SelectionColor")!
            selectedBackgroundView = UIView()
        } else {
            checkMarkView.removeFromSuperview()
            goalDescription.textColor = UIColor(named: "TitleColor")!
            selectedBackgroundView = UIView()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: _) has not been implemented.")
    }
    
    func buildViewHierarchy() {
        contentView.addSubview(goalDescription)
        contentView.addSubview(goalBullet)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            goalBullet.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            goalBullet.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            goalBullet.heightAnchor.constraint(equalToConstant: 16),
            goalBullet.widthAnchor.constraint(equalToConstant: 16)
        ])
        
        NSLayoutConstraint.activate([
            goalDescription.leadingAnchor.constraint(equalTo: goalBullet.trailingAnchor, constant: 16),
            goalDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            goalDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            goalDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)

        ])
    }
    
    func setupAdditionalConfigurantion() {
        contentView.backgroundColor = UIColor(named: "CardsColor")
    }
}
