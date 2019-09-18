//
//  HealthHeaderView.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 18/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class HealthHeaderView: UIView, ViewCode {
    
    var iconView: UIImageView!
    var titleLabel: CustomizableLabel!

    func buildViewHierarchy() {
        //
    }
    
    func setupConstraints() {
        //
    }
    
    func setupAdditionalConfigurantion() {
        //
    }
    
    init(icon: UIImage, title: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
