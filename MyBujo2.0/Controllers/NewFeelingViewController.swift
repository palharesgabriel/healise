//
//  NewFeelingViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 02/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

protocol NewFeelingViewControllerDelegate {
    func didAddFeeling()
}


class NewFeelingViewController: UIViewController, ViewCode, Blurable {

    var bluredView: UIView?
    let feelingsView = FeelingsView()
    var day: Day!
    
    var delegate: NewFeelingViewControllerDelegate!
    
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
            feelingsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            feelingsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feelingsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            feelingsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
        
    }
    
    func setupAdditionalConfigurantion() {
        feelingsView.backgroundColor = .white
    }
    
    @objc func didDismissModal() {
        day.feeling = Feeling(rawValue: (feelingsView.feelingsCardView.selectedFeeling?.feelingTitle.text)!)
        day.save()
        dismiss(animated: true) {
            self.delegate.didAddFeeling()
        }
    }
}
