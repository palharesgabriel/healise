//
//  ViewController.swift
//  MyBujo2.0
//
//  Created by Gabriel Palhares on 19/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit
import JTAppleCalendar
class ViewController: UIViewController {
    var calendarView: JTACMonthView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
        constraintCalendarView()
        calendarView.register(DayCell.self, forCellWithReuseIdentifier: "dateCell")
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
    }
    
    func constraintCalendarView(){
        calendarView = JTACMonthView()
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
            ])
        calendarView.backgroundColor = .clear
    }
}

extension ViewController: JTACMonthViewDelegate, JTACMonthViewDataSource{
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let configParameters = ConfigurationParameters(startDate: (CalendarManager.shared.year.months[1]?.days.first)!, endDate: (CalendarManager.shared.year.months[12]?.days.last)!, numberOfRows: 6, calendar: Calendar.current, generateInDates: .forAllMonths, generateOutDates: .tillEndOfRow, firstDayOfWeek: .monday)
        return configParameters
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        //
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        guard let cell = calendarView.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as? DayCell else { return JTACDayCell()}
        cell.label.text = cellState.text
        return cell
    }
}

