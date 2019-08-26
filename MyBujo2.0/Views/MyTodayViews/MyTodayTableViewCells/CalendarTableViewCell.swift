//
//  CalendarTableViewCell.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 26/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell, ViewCode {
    
    var calendarView: CalendarView!
    
    func buildViewHierarchy() {
        contentView.addSubview(calendarView)
    }
    
    func setupConstraints() {
        constraintCalendar()
    }
    
    func setupAdditionalConfigurantion() {
        //
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    func setupCell(calendarType: CalendarType){
        calendarView = CalendarView(with: calendarType)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func constraintCalendar(){
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            calendarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            calendarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            calendarView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
//            calendarView.heightAnchor.constraint(equalToConstant: 168)
            ])
    }

}
