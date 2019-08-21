//
//  MonthHeader.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 20/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import JTAppleCalendar

class MonthHeader: JTACMonthReusableView{
    var titleLabel = UILabel()
    var weekDaysHeader = WeekDaysView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintTitleLabel()
        constraintWeekDaysHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraintTitleLabel(){
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        titleLabel.textColor = .black
    }
    
    func constraintWeekDaysHeader(){
        addSubview(weekDaysHeader)
        weekDaysHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weekDaysHeader.leadingAnchor.constraint(equalTo: leadingAnchor),
            weekDaysHeader.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            weekDaysHeader.trailingAnchor.constraint(equalTo: trailingAnchor),
            weekDaysHeader.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }
    
    func configureHeader(start: Date){
        let formatter = DateFormatter()  // Declare this outside, to avoid instancing this heavy class multiple times.
        formatter.dateFormat = "MMMM"
        titleLabel.text = formatter.string(from: start)
        titleLabel.font = UIFont(name: "AvenirNext-Medium", size: 32)
    }
}
