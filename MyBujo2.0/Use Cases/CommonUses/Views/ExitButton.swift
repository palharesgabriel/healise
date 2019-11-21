//
//  ExitButton.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 10/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class ExitButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle("X", for: .normal)
        titleLabel!.font = UIFont.systemFont(ofSize: 16)
        setTitleColor(.titleColor, for: .normal)
        backgroundColor = .clear
		titleLabel?.textAlignment = .right
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
