//
//  GoalsTableViewCell.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 26/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class GoalsTableViewCell: UITableViewCell, ViewCode {
    func buildViewHierarchy() {
        //
    }
    
    func setupConstraints() {
        //
    }
    
    func setupAdditionalConfigurantion() {
        //
    }
    
    func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
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
