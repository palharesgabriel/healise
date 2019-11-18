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
        reusableView = feelingsView
    }
    
    // MARK: Functions
    func buildViewHierarchy() {
        view.addSubview(feelingsView)
        feelingsView.doneButton.addTarget(self, action: #selector(didDismissModal), for: .touchDown)
     }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            feelingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feelingsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            feelingsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            feelingsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    func setupAdditionalConfigurantion() {
        feelingsView.backgroundColor = UIColor(named: "CardsColor")
    }

    // MARK: Action Buttons
    @objc func didDismissModal() {
		CalendarManager.shared.selectedDay.feeling = feelingsView.selectedFeeling
        CalendarManager.shared.selectedDay.save()
        delegate.didAddFeeling(date: CalendarManager.shared.selectedDay.date!)
        dismiss(animated: true, completion: nil)
    }
}
