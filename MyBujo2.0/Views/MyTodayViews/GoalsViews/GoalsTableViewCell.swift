//
//  GoalsTableViewCell.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 26/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//
import UIKit

class GoalsTableViewCell: UITableViewCell, ViewCode {

    var goalsView = GoalsView()
    
    func buildViewHierarchy() {
        contentView.addSubview(goalsView)
    }
    
    func setupConstraints() {
        goalsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goalsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            goalsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            goalsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            goalsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        
    }
    
    func setupCell(){
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
