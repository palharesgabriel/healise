//
//  FeelingView.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 02/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class FeelingView: UIView, ViewCode {
    
    var isSelected = false
    
    let feelingCircle: UIView = {
       let v = UIView()
       v.translatesAutoresizingMaskIntoConstraints = false
       
       return v
    }()
    
    let feelingTitle: UILabel = {
       let lbl = UILabel()
       lbl.translatesAutoresizingMaskIntoConstraints = false
       lbl.textAlignment = .center
       return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    convenience init(title: String, circleColor: UIColor) {
        self.init()
        feelingTitle.text = title
        feelingCircle.backgroundColor = circleColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(feelingCircle)
        addSubview(feelingTitle)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            feelingCircle.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            feelingCircle.widthAnchor.constraint(equalToConstant: 24),
            feelingCircle.heightAnchor.constraint(equalToConstant: 24),
            feelingCircle.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            feelingTitle.topAnchor.constraint(equalTo: feelingCircle.bottomAnchor, constant: 8),
            feelingTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            feelingTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            feelingTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        feelingCircle.clipsToBounds = true
        feelingCircle.layer.masksToBounds = false
        feelingCircle.layer.cornerRadius = 12
    }
    
    func didSelected() {
        if isSelected {
            feelingCircle.layer.borderColor = UIColor.clear.cgColor
            feelingCircle.self.layer.borderWidth = 1
        } else {
            feelingCircle.layer.borderColor = UIColor.black.cgColor
            feelingCircle.self.layer.borderWidth = 5
        }

        self.isSelected = !isSelected
    }
    
}
