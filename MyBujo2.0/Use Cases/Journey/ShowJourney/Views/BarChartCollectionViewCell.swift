//
//  PieChartCollectionViewCell.swift
//  MyBujo2.0
//
//  Created by aluno on 26/11/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit
import Charts

class BarChartCollectionViewCell: UICollectionViewCell, ViewCode {
    let labelStrings = ["Drawings", "Notes", "Photos", "Audios"]
    var dataEntries: [BarChartDataEntry] = []
    let barChartView: BarChartView = {
        let barChart = BarChartView()
        barChart.translatesAutoresizingMaskIntoConstraints = false
        return barChart
    }()
    
    func buildViewHierarchy() {
        contentView.addSubview(barChartView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            barChartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            barChartView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            barChartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            barChartView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        barChartView.drawGridBackgroundEnabled = false
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawLabelsEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawAxisLineEnabled = false
        barChartView.rightAxis.drawLabelsEnabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawLabelsEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.labelPosition = .bottom
        
    }
    
    func populateChartView(monthData: MonthData){
        barChartView.noDataText = "No Data"
        appendDataEntry(x: 0, y: monthData.numberOfDrawings, image: "pencil.and.outline" )
        appendDataEntry(x: 1, y: monthData.numberOfNotes, image: "text.justifyleft")
        appendDataEntry(x: 2, y: monthData.numberOfPhotos, image: "camera")
        appendDataEntry(x: 3, y: monthData.numberOfVoiceRecords, image: "mic")
        
        let barChartDataSet = BarChartDataSet(entries: dataEntries, label: "Interactions")
        barChartDataSet.colors = [UIColor(named: "ActionColor") ?? .blue]
        let barChartData = BarChartData(dataSet: barChartDataSet)
        barChartData.setDrawValues(false)
        barChartView.data = barChartData
        
    }
    
    func appendDataEntry(x: Double, y: Int, image: String){
        let configuration = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
        let icon = UIImage(systemName: image, withConfiguration: configuration)
        dataEntries.append(BarChartDataEntry(x: x, y: Double(y), icon: icon))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BarChartCollectionViewCell: IAxisValueFormatter{
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return labelStrings[Int(value) % labelStrings.count]
    }
}
