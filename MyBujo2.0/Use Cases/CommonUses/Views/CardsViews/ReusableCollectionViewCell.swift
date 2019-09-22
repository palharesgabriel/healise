//
//  ReusableCollectionViewCell.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 15/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class ReusableCollectionViewCell: UICollectionViewCell, Shadow {

    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        addShadow(view: self)
      
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Functions
    func incrementLabel(to endValue: Int, labelNumber: UILabel) {
        labelNumber.text = "0"
        let duration: Double = 2.0
        
        DispatchQueue.global().async {
            for iiii in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.sync {
                    labelNumber.text =  String(iiii)
                }
            }
        }
    }

    
}
