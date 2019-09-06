//
//  NavigationButton.swift
//  MyBujo2.0
//
//  Created by Rennan Rebouças on 06/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class NavigationButton: UIButton {
    
    var id: Int!
    
    static var selectedId = 0
    
    convenience init(title: String, icon: String, idColor: Int) {
        self.init()
        self.id = idColor
        let icon = UIImage(named: icon)?.withRenderingMode(.alwaysTemplate)
        self.setImage(icon, for: .normal)
        self.imageView?.tintColor = UIColor(named: "TitleColor")
        self.imageView?.contentMode = .scaleAspectFit
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.contentHorizontalAlignment = .left
        self.setTitleColor(UIColor(named:"TitleColor")!, for: .normal)
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 15
    }
    
    func changeColors() {
        if id == NavigationButton.selectedId {
            imageView?.tintColor = .white
            setTitleColor(UIColor.white, for: .normal)
            titleLabel?.textColor = .white
            backgroundColor = UIColor(named: "StartColor")
        }
            
        else {
            imageView?.tintColor = UIColor(named: "TitleColor")
            titleLabel?.textColor = UIColor(named: "TitleColor")
            backgroundColor = .clear
        }
    }
}
