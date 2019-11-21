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

class NewFeelingViewController: UIViewController, ViewCode {
    // MARK: Properties
    let feelingsView = FeelingsView()
    weak var delegate: NewFeelingViewControllerDelegate!
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: Functions
    func buildViewHierarchy() {
        view.addSubview(feelingsView)
        feelingsView.doneButton.addTarget(self, action: #selector(didDismissModal), for: .touchDown)
     }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            feelingsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            feelingsView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            feelingsView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            feelingsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    func setupAdditionalConfigurantion() {
        feelingsView.backgroundColor = .cardsColor
    }

    // MARK: Action Buttons
    @objc func didDismissModal() {
		CalendarManager.shared.selectedDay.feeling = feelingsView.selectedFeeling
        CalendarManager.shared.selectedDay.save()
        delegate.didAddFeeling(date: CalendarManager.shared.selectedDay.date!)
        dismiss(animated: true, completion: nil)
    }
}
