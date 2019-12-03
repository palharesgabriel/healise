//
//  CalendarTableViewCell.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 26/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit
import JTAppleCalendar


    // MARK: Enum
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
    
    var touched = false
    // MARK: Properties
    
    static let reuseIdentifier = "CalendarTableViewCellIdentifier"
    
    var type: CalendarType!
    weak var delegate: CalendarTableViewCellDelegate!
    
    var shadowView = ShadowView()
    
    var calendarView: JTACMonthView = {
        let calendarView = JTACMonthView(frame: .zero)
        calendarView.backgroundColor = .cardsColor
        calendarView.clipsToBounds = true
        calendarView.layer.cornerRadius = 16
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.scrollDirection = .horizontal
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        return calendarView
    }()
    
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Functions
    func buildViewHierarchy() {
        contentView.addSubviews([shadowView, calendarView])
    }
    
    func setupConstraints() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            calendarView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 4),
            calendarView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -4),
            calendarView.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 4),
            calendarView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -4)
            ])
    }
    func setupAdditionalConfigurantion() {
        contentView.backgroundColor = .clear
        selectionStyle = .none
        calendarView.register(DayCell.self, forCellWithReuseIdentifier: "dateCell")
        calendarView.register(NavigationHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "monthHeader")
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
    }
    
    func setupCell(calendarType: CalendarType, date: Date) {
        type = calendarType
        setupView()
        calendarView.scrollToDate(date, animateScroll: false)
//        if calendarView.selectedDates.count == 0 {
//            calendarView.selectDates([date])
//        }
    }

    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let visibleDates = calendarView.visibleDates()
        calendarView.viewWillTransition(to: .zero, with: coordinator, anchorDate: visibleDates.monthDates.first?.date)
    }
}


    // MARK: Extensions
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
            let configParameters = ConfigurationParameters(startDate: dateFormatter.date(from: "\(Calendar.current.component(.year, from: Date())) 01 01")!, endDate: dateFormatter.date(from: "\(Calendar.current.component(.year, from: Date())) 12 31")!, numberOfRows: type.number,calendar: Calendar.current, generateInDates: .forAllMonths, generateOutDates: .tillEndOfRow, firstDayOfWeek: .sunday)
            return configParameters
        }
        
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        guard let cell = calendarView.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as? DayCell else { return JTACDayCell()}
        cell.setupCell(cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
//        guard let cell = cell as? DayCell else { return }
//        cell.setupCell(cellState: cellState)
        delegate.didSelectDate(date: date)
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? DayCell else { return }
        cell.setupCell(cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        
        
        guard let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "monthHeader", for: indexPath) as? NavigationHeader else { return  JTACMonthReusableView()}
        header.configureHeader(start: range.start)
        header.delegate = self
        print(indexPath)
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 74)
    }
    
    func calendar(_ calendar: JTACMonthView, shouldSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool {
        guard let cell = cell else { return false }
        if cellState.dateBelongsTo == .thisMonth && !cell.isSelected {
            return true
        } else if cellState.dateBelongsTo == .thisMonth && cell.isSelected {
            delegate.shouldShowAddFeelingModal()
            return true
        }
        return false
    }
}

extension CalendarTableViewCell: NavigationHeaderDelegate {
    func didTapLeftButton() {
        calendarView.scrollToSegment(.previous)
        CalendarManager.shared.selectedMonthComponent -= CalendarManager.shared.selectedMonthComponent > 1 ? 1 : 0
        delegate?.didScroll(direction: .left)
    }
    
    func didTapRightButton() {
        calendarView.scrollToSegment(.next)
        CalendarManager.shared.selectedMonthComponent += CalendarManager.shared.selectedMonthComponent < 12 ? 1 : 0
        delegate?.didScroll(direction: .left)
    }
    
    
}
