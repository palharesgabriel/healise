//
//  AudiosTableView.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 17/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class AudiosTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AudiosTableView: ViewCode {
    
    func buildViewHierarchy() {
        //
    }
    
    func setupConstraints() {
        //
    }
    
    func setupAdditionalConfigurantion() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = .yellow
        self.separatorStyle = .none
        self.register(UITableViewCell.self, forCellReuseIdentifier: "AudioCell")
    }
    
}
