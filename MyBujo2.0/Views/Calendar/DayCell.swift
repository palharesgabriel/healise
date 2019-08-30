//
//  DayCell.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 19/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import JTAppleCalendar

class DayCell: JTACDayCell, ViewCode {

    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        return label
    }()
    
    var moodIndicator: UIView = {
        let moodIndicator = UIView()
        moodIndicator.clipsToBounds = true
        moodIndicator.layer.cornerRadius = 2
        moodIndicator.backgroundColor = .green
        return moodIndicator
    }()
    
    var selectedView: UIView = {
        let selectedView = UIView()
        selectedView.clipsToBounds = true
        selectedView.backgroundColor = UIColor(displayP3Red: 255/255, green: 232/255, blue: 165/255, alpha: 1)
        selectedView.isHidden = true
        return selectedView
    }()
    
    func buildViewHierarchy() {
        contentView.addSubview(selectedView)
        contentView.addSubview(label)
        contentView.addSubview(moodIndicator)
    }
    
    func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.widthAnchor.constraint(equalTo: label.heightAnchor)
            ])
        
        moodIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moodIndicator.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            moodIndicator.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 2),
            moodIndicator.widthAnchor.constraint(equalToConstant: 4),
            moodIndicator.heightAnchor.constraint(equalToConstant: 4)
            ])
        
        selectedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectedView.widthAnchor.constraint(equalToConstant: 40),
            selectedView.heightAnchor.constraint(equalTo: selectedView.widthAnchor),
            selectedView.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            selectedView.centerYAnchor.constraint(equalTo: label.centerYAnchor)
            ])
        
        
    }
    
    func setupAdditionalConfigurantion() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
//        contentView.backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupCell(cellState: CellState) {
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
        } else {
            selectedView.isHidden = true
        }
        selectedView.layer.cornerRadius = 20
    }
}
