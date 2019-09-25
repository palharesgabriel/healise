//
//  CustomizableButton.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 18/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class CustomizableLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    init(title: String, size: CGFloat, color: UIColor) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        text = title
        textColor = color
        font = UIFont(name: "AvenirNext-Medium", size: size)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
