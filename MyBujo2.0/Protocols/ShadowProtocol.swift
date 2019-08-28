//
//  ShadowProtocol.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 20/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit

protocol Shadow: UIView {
    func addShadow()
}

extension Shadow {
    func addShadow() {
        clipsToBounds = true
        layer.masksToBounds = false
        layer.cornerRadius = 16
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.2
        layer.shadowColor = UIColor.black.cgColor
    }
}
