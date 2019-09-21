//
//  CounterGoalsCard.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 20/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class CounterGoalsCard: ReusableCollectionViewCell, ViewCode {
    
    
    // MARK: Properties
     let number = TitleLabel(title: "0")

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        incrementLabel(to: 1000)
        number.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // MARK: Functions
    func incrementLabel(to endValue: Int) {
        
        let duration: Double = 2.0
        
        DispatchQueue.global().async {
            for iiii in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.sync {
                    self.number.text =  String(iiii)
                }
            }
        }
    }
    
    func buildViewHierarchy() {
        addSubviews([number])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            number.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            number.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor)
            ])
    }
    
    func setupAdditionalConfigurantion() {

    }
}
