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
        pieChartView.drawHoleEnabled = false
    }
    
    func populateChartView(numberOfFeelings: [FeelingNumber]) {
        var dataEntries: [PieChartDataEntry] = []
        
        numberOfFeelings.forEach({
            if $0.number > 0 {
                let dataEntry = PieChartDataEntry(value: $0.number, label: $0.feeling.rawValue)
                dataEntries.append(dataEntry)
            }
        })
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Feelings")
        pieChartDataSet.drawValuesEnabled = false
        pieChartDataSet.colors = []
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        numberOfFeelings.forEach({$0.number > 0 ? pieChartDataSet.colors.append($0.feeling.color) : nil})
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
