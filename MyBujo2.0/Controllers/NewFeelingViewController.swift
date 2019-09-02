//
//  NewFeelingViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 02/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit


class NewFeelingViewController: UIViewController, ViewCode, Blurable {

    var bluredView: UIView?
    let feelingsView = FeelingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bluredView = addBlur()
        setupView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didDismissModal))
        bluredView?.addGestureRecognizer(tapGesture)
    }
    
    func buildViewHierarchy() {
        view.addSubview(feelingsView)
        feelingsView.doneButton.addTarget(self, action: #selector(didDismissModal), for: .touchDown)
     }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            feelingsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            feelingsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feelingsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            feelingsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
        
    }
    
    func setupAdditionalConfigurantion() {
        feelingsView.backgroundColor = .white
    }
    
    @objc func didDismissModal() {
        let day = Day(context: CoreDataManager.context)
        day.feel = feelingsView.feelingsCardView.selectedFeeling?.feelingTitle.text?.lowercased()
        day.save()
        dismiss(animated: true) {
            
        }
    }
}
