//
//  ShadowProtocol.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 20/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit

protocol Shadow: class {
    func addShadow(view: UIView)
}

extension Shadow {
    func addShadow(view: UIView) {
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 16
        view.backgroundColor = .cardsColor
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.08
        view.layer.shadowColor = UIColor.black.cgColor
    }
}
