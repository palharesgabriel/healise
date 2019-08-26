//
//  CalendarView.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 20/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit
import JTAppleCalendar

enum CalendarType{
    case month
    case week
    
    var number: Int {
        switch self {
        case .month:
            return 6
        default:
            return 1
        }
    }
}

class CalendarView: UIView, Shadow {
    var calendarView: JTACMonthView!
    var type: CalendarType!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    init(with type: CalendarType) {
        super.init(frame: .zero)
        self.type = type
        setupCell()
    }
    
    
    
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let visibleDates = calendarView.visibleDates()
        calendarView.viewWillTransition(to: .zero, with: coordinator, anchorDate: visibleDates.monthDates.first?.date)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(){
        backgroundColor = .white
        addShadow()
        constraintCalendarView()
        calendarView.register(DayCell.self, forCellWithReuseIdentifier: "dateCell")
        calendarView.register(MonthHeader.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "monthHeader")
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
        calendarView.scrollToDate(Date(), animateScroll: false)
    }
    
    func constraintCalendarView(){
        calendarView = JTACMonthView()
        addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            calendarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            calendarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            calendarView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            ])
        calendarView.backgroundColor = .clear
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.scrollDirection = .horizontal
        calendarView.showsHorizontalScrollIndicator = false
        
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
    }
}

extension CalendarView: JTACMonthViewDelegate, JTACMonthViewDataSource{
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DayCell else { return }
        cell.configureCell(cellState: cellState)
    }
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        
        
        let configParameters = ConfigurationParameters(startDate: dateFormatter.date(from: "\(Calendar.current.component(.year, from: Date())) 01 01")!, endDate: dateFormatter.date(from: "\(Calendar.current.component(.year, from: Date())) 12 31")!, numberOfRows: type.number,calendar: Calendar.current, generateInDates: .forAllMonths, generateOutDates: .tillEndOfRow, firstDayOfWeek: .monday)
        return configParameters
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        guard let cell = calendarView.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as? DayCell else { return JTACDayCell()}
        cell.configureCell(cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DayCell else { return }
        cell.configureCell(cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DayCell else { return }
        cell.configureCell(cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        
        
        guard let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "monthHeader", for: indexPath) as? MonthHeader else { return  JTACMonthReusableView()}
        header.configureHeader(start: range.start)
        print(indexPath)
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 90)
    }
    
    func calendar(_ calendar: JTACMonthView, shouldSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool {
        if cellState.dateBelongsTo == .thisMonth{
            return true
        }
        return false
    }
}

