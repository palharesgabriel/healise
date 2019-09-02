//
//  HeaderViewFactory.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 27/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit

struct HeaderViewFactory {
    
    
    var tableView: UITableView!
    var section = 0
    
    init(tableView: UITableView, section: Int) {
        self.tableView = tableView
        self.section = section
    }
    
    func build() -> TableViewHeaderView?{
        
        switch section {
        case 0:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CalendarTableViewHeaderView.reuseIdentifier) as? TableViewHeaderView else { return nil }
            header.setupHeader(headerTitle: "Calendar")
            return header
        case 1:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: GoalsTableViewHeaderView.reuseIdentifier) as? TableViewHeaderView else { return nil }
            header.setupHeader(headerTitle: "Goals", buttonTitle: "+")
            return header
        case 2:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MediaTableViewHeaderView.reuseIdentifier) as? TableViewHeaderView else { return nil }
            header.setupHeader(headerTitle: "Media")
            return header
        default:
            return nil
        }
    }

    func height() -> CGFloat {
        switch section {
        case 0:
            return 30
        case 1:
            return 30
        case 2:
            return 30
        default:
            return 0
        }
    }
}
