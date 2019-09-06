//
//  UiButton+Extension.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 04/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

extension UIButton {
    
    
//    convenience init(title: String, icon: String, id: Int) {
//        self.init()
//        let icon = UIImage(named: icon)?.withRenderingMode(.alwaysTemplate)
//        self.setImage(icon, for: .normal)
//        self.imageView?.contentMode = .scaleAspectFit
//        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.setTitle(title, for: .normal)
//        self.contentHorizontalAlignment = .left
//        self.setTitleColor(UIColor(named:"TitleColor")!, for: .normal)
//    }
    
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
