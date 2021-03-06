//
//  GoalsTableViewCell.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 26/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class GoalsTableViewCell: UITableViewCell, ViewCode {

    var goalsView: GoalsView!
    
    func buildViewHierarchy() {
        contentView.addSubview(goalsView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            goalsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            goalsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            goalsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            goalsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
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
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
