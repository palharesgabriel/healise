//
//  GradientChartTableViewCell.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 06/11/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit
import Charts

class GradientChartTableViewCell: UITableViewCell, ViewCode {
    let gradientView = GradientView()
    
    func buildViewHierarchy() {
        contentView.addSubview(gradientView)
    }
    
    func setupConstraints() {
        gradientView.fillSuperview()
    }
    
    func setupAdditionalConfigurantion() {
        setChart()
        backgroundColor = .clear
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setChart() {
        let dataEntries = (0...30).map { (int) -> ChartDataEntry in
            let yyy = Int.random(in: 0...10)
            return ChartDataEntry(x: Double(int), y: Double(int * yyy))
        }
        let line = LineChartDataSet(entries: dataEntries, label: "Days")
        line.colors = [NSUIColor.blue]
        line.circleColors = [NSUIColor.blue]
        line.mode = .cubicBezier
        line.cubicIntensity = 0.2
        
        line.fill = Fill.init(CGColor: UIColor.blue.cgColor)
        line.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: line)
        gradientView.data = data
    }
}
