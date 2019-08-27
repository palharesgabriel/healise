//
//  ViewCode.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 21/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation

protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfigurantion()
    func setupView()
}

extension ViewCode {
    func setupView() {
        buildViewHierarchy()
        setupAdditionalConfigurantion()
        setupConstraints()
    }
}
