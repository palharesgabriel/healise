//
//  GoalsTableViewHeaderView.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 27/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class GoalsTableViewHeaderView: UITableViewHeaderFooterView, ViewCode {
    static let reuseIdentifier = "GoalsTableViewHeaderViewIdentifier"
    
    let headerLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Goals"
        lbl.font = UIFont(name: "AvenirNext-Medium", size: 28)
        lbl.textColor = UIColor(named: "TitleColor")!
        return lbl
    }()
    
    let buttonAddGoal: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor(named: "TitleColor")!, for: .normal)
        btn.setTitle("+", for: .normal)
        btn.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 28)
        return btn
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        contentView.addSubview(headerLabel)
        contentView.addSubview(buttonAddGoal)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buttonAddGoal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            buttonAddGoal.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        backgroundView = UIView()
    }
}
