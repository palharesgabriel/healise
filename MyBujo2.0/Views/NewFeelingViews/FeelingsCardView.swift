//
//  FeelingsCardView.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 02/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class FeelingsCardView: UIView, ViewCode {
    
    let feelsStackView = [
        FeelingView(title: "Happy", circleColor: .yellow)
        ,FeelingView(title: "Sad", circleColor: .purple)
        ,FeelingView(title: "Anger", circleColor: .red)
        ,FeelingView(title: "Lovely", circleColor: .magenta)
    ]
    
    let stackView: UIStackView = {
       let stack = UIStackView()
       stack.translatesAutoresizingMaskIntoConstraints = false
       return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
        stackView.distribution = .fillEqually
        feelsStackView.forEach { view in
            stackView.addArrangedSubview(view)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func setupAdditionalConfigurantion() {

    }
    
}
