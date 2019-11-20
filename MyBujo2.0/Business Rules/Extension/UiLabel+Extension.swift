//
//  UiLabel+Extension.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 04/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, textColor: UIColor, localizableString: String) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.font = font
        self.text = NSLocalizedString(localizableString, comment: localizableString)
        self.textAlignment = .center
        self.textColor = textColor
        self.adjustsFontSizeToFitWidth = true
    }
}

extension UILabel {
    convenience init(dayName: String) {
        self.init()
        text = NSLocalizedString(dayName, comment: dayName)
    }
}
