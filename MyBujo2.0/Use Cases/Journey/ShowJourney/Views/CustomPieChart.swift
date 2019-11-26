//
//  CustomPieChart.swift
//  MyBujo2.0
//
//  Created by aluno on 26/11/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit
import Charts

class CustomPieChart: PieChartView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
