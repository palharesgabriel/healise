//
//  CalendarTableViewCell.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 26/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit
import JTAppleCalendar

enum CalendarType {
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

class CalendarTableViewCell: UITableViewCell, ViewCode {
    static let reuseIdentifier = "CalendarTableViewCellIdentifier"
    
    let shadowView = ShadowView(frame: .zero)
    
    var delegate: CalendarTableViewCellDelegate!
    
    var calendarView: JTACMonthView = {
        let calendarView = JTACMonthView(frame: .zero)
        calendarView.backgroundColor = .clear
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.scrollDirection = .horizontal
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.clipsToBounds = true
        calendarView.layer.cornerRadius = 16
        calendarView.backgroundColor = .white
        
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        return calendarView
    }()
    
    var type: CalendarType!
    
    func buildViewHierarchy() {
        contentView.addSubview(shadowView)
        contentView.addSubview(calendarView)
    }
    
    func setupConstraints() {
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            ])
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            calendarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            calendarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            calendarView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            //            calendarView.heightAnchor.constraint(equalToConstant: 168)
            ])
    }
    
    func setupAdditionalConfigurantion() {
        contentView.backgroundColor = .clear
        selectionStyle = .none
        calendarView.register(DayCell.self, forCellWithReuseIdentifier: "dateCell")
        calendarView.register(MonthHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "monthHeader")
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
    }
    
    func setupCell(calendarType: CalendarType) {
        type = calendarType
        setupView()
        calendarView.scrollToDate(Date(), animateScroll: false)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
    }
    
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let visibleDates = calendarView.visibleDates()
        calendarView.viewWillTransition(to: .zero, with: coordinator, anchorDate: visibleDates.monthDates.first?.date)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension CalendarTableViewCell: JTACMonthViewDelegate, JTACMonthViewDataSource {
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DayCell else { return }
        cell.setupCell(cellState: cellState)
    }
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        
        if type.number == 6 {
            let configParameters = ConfigurationParameters(startDate: dateFormatter.date(from: "\(Calendar.current.component(.year, from: Date())) 01 01")!, endDate: dateFormatter.date(from: "\(Calendar.current.component(.year, from: Date())) 12 31")!, numberOfRows: type.number,calendar: Calendar.current, generateInDates: .forAllMonths, generateOutDates: .tillEndOfRow, firstDayOfWeek: .sunday)
            return configParameters
        } else {
            let configParameters = ConfigurationParameters(startDate: dateFormatter.date(from: "\(Calendar.current.component(.year, from: Date())) 01 01")!, endDate: dateFormatter.date(from: "\(Calendar.current.component(.year, from: Date())) 12 31")!, numberOfRows: type.number,calendar: Calendar.current, generateInDates: .forFirstMonthOnly, generateOutDates: .off, firstDayOfWeek: .sunday)
            return configParameters
        }
        
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        guard let cell = calendarView.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as? DayCell else { return JTACDayCell()}
        cell.setupCell(cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DayCell else { return }
        delegate.didSelectDate(date: date)
        cell.setupCell(cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DayCell else { return }
        cell.setupCell(cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        
        
        guard let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "monthHeader", for: indexPath) as? MonthHeader else { return  JTACMonthReusableView()}
        header.configureHeader(start: range.start)
        print(indexPath)
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 82)
    }
    
    func calendar(_ calendar: JTACMonthView, shouldSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool {
        if cellState.dateBelongsTo == .thisMonth {
            return true
        }
        return false
    }
}
