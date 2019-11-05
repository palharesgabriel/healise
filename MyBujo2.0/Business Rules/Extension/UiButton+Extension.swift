//
//  UiButton+Extension.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 04/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

extension UIButton {
    
    
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
    
}
