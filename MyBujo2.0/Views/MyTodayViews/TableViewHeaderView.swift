//
//  GoalsTableViewHeaderView.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 27/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

protocol TableViewHeaderViewDelegate {
    func addGoal()
}

class TableViewHeaderView: UITableViewHeaderFooterView, ViewCode {
    var hasButton: Bool = false
    var delegate: TableViewHeaderViewDelegate?
    
    let headerLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "AvenirNext-Medium", size: 24)
        lbl.textColor = UIColor(named: "TitleColor")!
        return lbl
    }()
    
    lazy var buttonAddGoal: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor(named: "ActionColor")!, for: .normal)
        btn.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 24)
        return btn
    }()
    
    func setupHeader(headerTitle: String, buttonTitle: String? = nil) {
        headerLabel.text = headerTitle
        if let buttonTitle = buttonTitle {
            hasButton = true
            buttonAddGoal.setTitle(buttonTitle, for: .normal)
        }
        setupView()
        
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
       
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        contentView.addSubview(headerLabel)
        if hasButton {
            contentView.addSubview(buttonAddGoal)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        if hasButton {
            NSLayoutConstraint.activate([
                buttonAddGoal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                buttonAddGoal.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
        
    }
    
    func setupAdditionalConfigurantion() {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundBlue")
        backgroundView = view
    }
}

class GoalsTableViewHeaderView: TableViewHeaderView {
    static let reuseIdentifier = "GoalsTableViewHeaderViewIdentifier"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.buttonAddGoal.addTarget(self, action: #selector(didAddGoalsViewController), for: .touchDown)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didAddGoalsViewController () {
        delegate?.addGoal()
    }
}

class CalendarTableViewHeaderView: TableViewHeaderView {
    static let reuseIdentifier = "CalendarTableViewHeaderViewIdentifier"
}

class MediaTableViewHeaderView: TableViewHeaderView {
    static let reuseIdentifier = "MediaTableViewHeaderViewIdentifier"
}
