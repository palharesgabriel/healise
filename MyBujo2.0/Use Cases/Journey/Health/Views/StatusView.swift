//
//  StatusView.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 18/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class StatusView: UIView, ViewCode {
    
    var titleLabel: TitleLabel!
    var statusLabel: CustomizableLabel!
    
    func buildViewHierarchy() {
        addSubviews([titleLabel, statusLabel])
    }
    
    func setupConstraints() {

    }
    
    func setupAdditionalConfigurantion() {
   
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupStatus(with type: HealthStatusType) {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel = TitleLabel(title: type.title)
        statusLabel = CustomizableLabel(title: "", size: 24, color: .black)
        setupView()
    }
}
