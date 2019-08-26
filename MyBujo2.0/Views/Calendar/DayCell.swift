//
//  DayCell.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 19/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import JTAppleCalendar

class DayCell: JTACDayCell{
    var label = UILabel()
    var moodIndicator = UIView()
    var selectedView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintLabel()
        constraintMoodIndicator()
        constraintSelectedView()
//        contentView.backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        constraintLabel()
    }
    
    func constraintLabel(){
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.widthAnchor.constraint(equalTo: label.heightAnchor)
            ])
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
    }
    
    func constraintMoodIndicator(){
        contentView.addSubview(moodIndicator)
        moodIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moodIndicator.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            moodIndicator.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 2),
            moodIndicator.widthAnchor.constraint(equalToConstant: 4),
            moodIndicator.heightAnchor.constraint(equalToConstant: 4),
            ])
        moodIndicator.clipsToBounds = true
        moodIndicator.layer.cornerRadius = 2
        moodIndicator.backgroundColor = .green
    }
    
    func constraintSelectedView(){
        contentView.addSubview(selectedView)
        selectedView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            selectedView.widthAnchor.constraint(equalTo: label.heightAnchor, multiplier: 2.0),
            selectedView.heightAnchor.constraint(equalTo: selectedView.widthAnchor),
            selectedView.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            selectedView.centerYAnchor.constraint(equalTo: label.centerYAnchor)
            ])
        selectedView.clipsToBounds = true
        selectedView.backgroundColor = UIColor(displayP3Red: 1/255, green: 1/255, blue: 1/255, alpha: 0.2)
        selectedView.isHidden = true
    }
    
    func configureCell(cellState: CellState) {
        label.text = cellState.text
        handleCellTextColor(cellState: cellState)
        handleCellSelected(cellState: cellState)
    }
    
    func handleCellTextColor(cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            label.textColor = UIColor(named:"TitleColor")!
        } else {
            label.textColor = UIColor.gray
        }
    }
    
    func handleCellSelected(cellState: CellState) {
        if cellState.isSelected {
            selectedView.isHidden = false
        }
        else {
            selectedView.isHidden = true
        }
        selectedView.layer.cornerRadius = selectedView.frame.size.width/2
    }
}
