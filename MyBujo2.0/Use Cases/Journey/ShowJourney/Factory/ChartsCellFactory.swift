//
//  ChartsCellFactory.swift
//  MyBujo2.0
//
//  Created by aluno on 27/11/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

struct ChartsCellFactory {
    private var collectionView: UICollectionView
    private var indexPath: IndexPath
    init(collectionView: UICollectionView, indexPath: IndexPath) {
        self.collectionView = collectionView
        self.indexPath = indexPath
    }
    
    var cell: UICollectionViewCell?{
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pieChartCell", for: indexPath) as? PieChartCollectionViewCell else { return nil }
            if let numberOfFeelings = CoreDataManager.getMonthData(month: CalendarManager.shared.currentMonthComponent)?.feelingsNumber{
                cell.populateChartView(numberOfFeelings: numberOfFeelings)
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "barChartCell", for: indexPath) as? BarChartCollectionViewCell else { return nil }
            if let monthData = CoreDataManager.getMonthData(month: CalendarManager.shared.currentMonthComponent){
                cell.populateChartView(monthData: monthData)
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
