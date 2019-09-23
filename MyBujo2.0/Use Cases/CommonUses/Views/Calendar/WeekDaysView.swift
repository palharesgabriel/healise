//
//  WeekDaysView'.swift
//  CalendarTest
//
//  Created by Adauto Pinheiro on 15/08/19.
//  Copyright © 2019 Adauto Pinheiro. All rights reserved.
//

import UIKit

class WeekDaysView: UIStackView {
    
    
    // MARK: Properties
    let daysNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        for index in daysNames {
            let label = UILabel()
            label.font = UIFont(name: "AvenirNext-Medium", size: 16)
            label.textAlignment = .center
            label.text = index
            label.textColor = UIColor(named:"TitleColor")!
            self.addArrangedSubview(label)
        }
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

}
