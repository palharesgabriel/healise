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
    
    
    // MARK: Properties
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        return label
    }()
    var moodIndicator: UIView = {
        let moodIndicator = UIView()
        moodIndicator.clipsToBounds = true
        moodIndicator.layer.cornerRadius = 3
        moodIndicator.isHidden = true
        return moodIndicator
    }()
    var selectedView: UIView = {
        let selectedView = UIView()
        selectedView.clipsToBounds = true
        selectedView.backgroundColor = UIColor(named: "SelectionColor")
        selectedView.isHidden = true
        return selectedView
    }()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: Functions
    func buildViewHierarchy() {
        contentView.addSubview(selectedView)
        contentView.addSubview(label)
        contentView.addSubview(moodIndicator)
    }
    func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        moodIndicator.translatesAutoresizingMaskIntoConstraints = false
        selectedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.widthAnchor.constraint(equalTo: label.heightAnchor),
            
            moodIndicator.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            moodIndicator.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0),
            moodIndicator.widthAnchor.constraint(equalToConstant: 6),
            moodIndicator.heightAnchor.constraint(equalToConstant: 6),
            
            selectedView.widthAnchor.constraint(equalToConstant: 48),
            selectedView.heightAnchor.constraint(equalTo: selectedView.widthAnchor),
            selectedView.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            selectedView.centerYAnchor.constraint(equalTo: label.centerYAnchor)
            ])
    }

    func setupCell(cellState: CellState) {
        label.text = cellState.text
        handleCellTextColor(cellState: cellState)
        handleCellSelected(cellState: cellState)
        moodIndicator.isHidden = true
        guard let result = CoreDataManager.fetch(entityClass: Day.self, predicate: EntityType.day(cellState.date.ignoringTime()!).predicate) else { return }
        guard let day = result.first as? Day else { return }
        handleMoodIndicator(feeling: day.feeling)
    }
    
    func handleCellTextColor(cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            label.textColor = UIColor(named:"TitleColor")!
        } else {
            label.textColor = UIColor.gray
        }
    }
    
    func handleCellSelected(cellState: CellState) {
        selectedView.isHidden = cellState.date.ignoringTime() == Date().ignoringTime() ? false : true
        selectedView.layer.cornerRadius = 24
    }
    func handleMoodIndicator(feeling: Feeling?) {
        if let feeling = feeling {
            moodIndicator.backgroundColor = feeling.color
            moodIndicator.isHidden = false
        } else {
            moodIndicator.isHidden = true
        }
        
    }
    func setupAdditionalConfigurantion() {
        
    }
}
