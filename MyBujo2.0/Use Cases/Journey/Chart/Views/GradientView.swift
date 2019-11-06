//
//  GradientChart.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 06/11/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit
import Charts

class GradientView: LineChartView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        drawGridBackgroundEnabled = false
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawGridLinesEnabled = false
        rightAxis.drawAxisLineEnabled = false
        rightAxis.drawGridLinesEnabled = false
        legend.enabled = false
        xAxis.enabled = false
        leftAxis.enabled = false
        rightAxis.enabled = false
        backgroundColor = .clear
    }
    
    func fillSuperview() {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: 16),
            trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: -16),
            topAnchor.constraint(equalTo: superview!.topAnchor, constant: 16),
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
