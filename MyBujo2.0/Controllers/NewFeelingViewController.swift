//
//  NewFeelingViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 02/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

    // MARK: Protocols
protocol NewFeelingViewControllerDelegate {
    func didAddFeeling(date: Date)
}

class NewFeelingViewController: UIViewController, ViewCode, Blurable {
    
    
    // MARK: Properties
    var bluredView: UIView?
    let feelingsView = FeelingsView()
    var delegate: NewFeelingViewControllerDelegate!
    var effect: UIVisualEffect?
    var visualEffect: UIVisualEffectView?
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        visualEffect = addBlur()
        effect = visualEffect?.effect
        visualEffect?.effect = nil
        bluredView = visualEffect?.contentView
        setupView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didDismissModal))
        bluredView?.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateIn(view: feelingsView, visualEffect: visualEffect!, effect: effect!)
    }
    
    // MARK: Functions
    func buildViewHierarchy() {
        view.addSubview(feelingsView)
        feelingsView.doneButton.addTarget(self, action: #selector(didDismissModal), for: .touchDown)
     }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            feelingsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
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
        animateOut(view: view, visualEffect: visualEffect!)
        
    }
}
