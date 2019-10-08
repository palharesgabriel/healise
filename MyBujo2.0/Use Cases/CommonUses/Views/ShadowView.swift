//
//  ShadowView.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 27/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class ShadowView: UIView, Shadow {

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "CardColors")
        addShadow(view: self)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
