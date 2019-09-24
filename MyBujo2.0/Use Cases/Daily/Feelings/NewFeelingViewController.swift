//
//  NewFeelingViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 02/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

    // MARK: Protocols
protocol NewFeelingViewControllerDelegate: class {
    func didAddFeeling(date: Date)
}

class NewFeelingViewController: NewBaseViewController, ViewCode {
    
    
    // MARK: Properties
    let feelingsView = FeelingsView()
    weak var delegate: NewFeelingViewControllerDelegate!
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didDismissModal))
        reusableView = feelingsView
    }
    
    // MARK: Functions
    func buildViewHierarchy() {
        view.addSubview(feelingsView)
        feelingsView.doneButton.addTarget(self, action: #selector(didDismissModal), for: .touchDown)
     }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            feelingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            feelingsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feelingsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            feelingsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
        
    }
    func setupAdditionalConfigurantion() {
        feelingsView.backgroundColor = .white
    }

    // MARK: Action Buttons
    @objc func didDismissModal() {
        CalendarManager.shared.selectedDay.feeling = feelingsView.feelingsCardView.selectedFeeling?.feeling
        CalendarManager.shared.selectedDay.save()
        delegate.didAddFeeling(date: CalendarManager.shared.selectedDay.date!)
        dismiss(animated: true, completion: nil)
    }
}