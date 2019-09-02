//
//  NewFeelingViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 02/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class FeelingsView: UIView, Shadow, ViewCode {
    
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
    
    let feelingsCardView = FeelingsCardView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
        addShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(feelingsCardTitle)
        addSubview(doneButton)
        addSubview(feelingsCardView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            feelingsCardTitle.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            feelingsCardTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            feelingsCardTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
          ])
        NSLayoutConstraint.activate([
            feelingsCardView.topAnchor.constraint(equalTo: feelingsCardTitle.bottomAnchor, constant: 8),
            feelingsCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            feelingsCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            feelingsCardView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -8)
            ])
        NSLayoutConstraint.activate([
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

class NewFeelingViewController: UIViewController, ViewCode, Blurable {

    var bluredView: UIView?
    let feelingsView = FeelingsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        bluredView = addBlur()
        setupView()
    }
    
    func buildViewHierarchy() {
        bluredView?.addSubview(feelingsView)
     }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            feelingsView.topAnchor.constraint(equalTo: bluredView!.topAnchor, constant: 16),
            feelingsView.centerXAnchor.constraint(equalTo: bluredView!.centerXAnchor),
            feelingsView.widthAnchor.constraint(equalTo: bluredView!.widthAnchor, multiplier: 0.9),
            feelingsView.heightAnchor.constraint(equalTo: bluredView!.heightAnchor, multiplier: 0.3)
        ])
        
    }
    
    func setupAdditionalConfigurantion() {
        feelingsView.backgroundColor = .white
    }
}
