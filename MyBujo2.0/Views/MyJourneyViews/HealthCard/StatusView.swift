//
//  StatusView.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 18/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

enum HealthStatusType {
    case move(_:Double)
    case exercise(_:Date)
    case sleep(_:Date)
    case mindful(_:Date)
    
    var color: UIColor {
        switch self {
        case .move:
            return UIColor()
        case .exercise:
            return UIColor()
        case .sleep:
            return UIColor()
        case .mindful:
            return UIColor()
        }
    }
    
    var title: String {
        switch self {
        case .move:
            return "Move"
        case .exercise:
            return "Exercise"
        case .sleep:
            return "Sleep Average"
        case .mindful:
            return "Mindful"
        }
    }
    
    var value: String {
        switch self {
        case .move(let calories):
            return "\(calories)cal"
        case .exercise(let time):
            //format
            return "\(time)"
        case .sleep(let time):
            //format
            return "\(time)"
        case .mindful(let time):
            //format
            return "\(time)"
        }
    }
    
}

class StatusView: UIView, ViewCode {
    func buildViewHierarchy() {
        addSubviews([titleLabel, statusLabel])
    }
    
    func setupConstraints() {
        //
    }
    
    func setupAdditionalConfigurantion() {
        //
    }
    
    
    var titleLabel: TitleLabel!
    var statusLabel: CustomizableLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(with type: HealthStatusType) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel = TitleLabel(title: type.title)
        statusLabel = CustomizableLabel(title: "", size: 24, color: .black)
        setupView()
        //
    }
}
