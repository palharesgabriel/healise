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
            goalsTableView.topAnchor.constraint(equalTo: topAnchor),
            goalsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            goalsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            goalsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        backgroundColor = .white
        self.goalsTableView.backgroundColor = .clear
    }
}
