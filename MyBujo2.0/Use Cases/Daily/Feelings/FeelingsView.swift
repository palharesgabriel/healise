//
//  FeelingsView.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 02/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit

class FeelingsView: UIView, Shadow, ViewCode {
    
    
    // MARK: Properties
    let feelingsCardView = FeelingsCardView()
    let feelingsCardTitle = UILabel(text: "How are you feeling today?", font: "AvenirNext-Medium", fontSize: 24, textColor: UIColor(named: "TitleColor")!)
    
    let doneButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Done", for: .normal)
        btn.titleLabel!.font = UIFont(name: "AvenirNext-Medium", size: 24)
        btn.setTitleColor(UIColor(named: "TitleColor"), for: .normal)
        return btn
    }()
    let feelingsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupView()
        addShadow(view: self)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(feelingsCardTitle)
        addSubview(doneButton)
        addSubview(feelingsCardView)
    }
    
    
    // MARK: Functions
    func setupConstraints() {
        NSLayoutConstraint.activate([
            feelingsCardTitle.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            feelingsCardTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            feelingsCardTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            feelingsCardView.topAnchor.constraint(equalTo: feelingsCardTitle.bottomAnchor, constant: 8),
            feelingsCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            feelingsCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            feelingsCardView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -8),
            
            doneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            doneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ])
        
        doneButton.setContentHuggingPriority(.defaultHigh, for: .vertical)
        doneButton.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    func setupAdditionalConfigurantion() {
        
    }
}
