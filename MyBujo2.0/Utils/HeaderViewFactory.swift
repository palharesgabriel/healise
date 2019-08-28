//
//  HeaderViewFactory.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 27/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit

enum HeaderView: Int {
    case calendar = 0
    case goals = 1
    case media = 2
}

struct HeaderViewFactory {
    static func build(section: Int) -> UITableViewHeaderFooterView? {
        switch section {
        case HeaderView.calendar.rawValue:
            return nil
        case HeaderView.goals.rawValue:
            return GoalsTableViewHeaderView()
        case HeaderView.media.rawValue:
            return nil
        default:
            return nil
        }
    }

    static func getHeight(section: Int) -> CGFloat {
        switch section {
        case HeaderView.goals.rawValue:
            return 30
        default:
            return 0
        }
    }
}



