//
//  PieChartCollectionViewCell.swift
//  MyBujo2.0
//
//  Created by aluno on 26/11/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit
import Charts

class PieChartCollectionViewCell: UICollectionViewCell, ViewCode {
    
    let pieChartView = CustomPieChart()
    
    func buildViewHierarchy() {
        contentView.addSubview(pieChartView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            pieChartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            pieChartView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            pieChartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            pieChartView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        
    }
    
    func populateChartView(){
        var dataEntries: [ChartDataEntry] = []
        dataEntries.append(ChartDataEntry(x: 0, y: 33))
        dataEntries.append(ChartDataEntry(x: 1, y: 67))
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Test")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartDataSet.colors = [Feeling.happy.color, Feeling.sad.color]
        pieChartView.data = pieChartData
       }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
