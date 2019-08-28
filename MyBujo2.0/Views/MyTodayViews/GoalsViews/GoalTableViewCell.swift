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
    
    let goalDescription: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Teste"
        lbl.font = UIFont(name: "AvenirNext-Medium", size: 18)
        lbl.textColor = UIColor(named: "TitleColor")!
        return lbl
    }()
    
    let goalBullet: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "TitleColor")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 2
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
        self.selectionStyle = .none
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
            goalBullet.heightAnchor.constraint(equalToConstant: 4),
            goalBullet.widthAnchor.constraint(equalToConstant: 4)
        ])
        
        NSLayoutConstraint.activate([
            goalDescription.leadingAnchor.constraint(equalTo: goalBullet.trailingAnchor, constant: 16),
            goalDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            goalDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            goalDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

        ])
    }
    
    func setupAdditionalConfigurantion() {
    
    }
}
