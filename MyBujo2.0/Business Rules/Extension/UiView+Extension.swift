//
//  CBuilder.swift
//  CBuilder
//
//  Created by Vinicius Mangueira on 28/08/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//
import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { (view) in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }
    
    func setShadow() {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 16
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.05
        self.layer.shadowColor = UIColor.black.cgColor
    }
}
