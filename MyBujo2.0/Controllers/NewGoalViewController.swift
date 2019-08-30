//
//  NewGoalViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 28/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.

import UIKit

class NewGoalViewController: UIViewController, ViewCode, Blurable {
    
    var day: Day!
    
    var bluredView: UIView?
    
    let formView = FormView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bluredView = addBlur()
        setupView()
        formView.delegate = self
    }
    
    func buildViewHierarchy() {
        bluredView?.addSubview(formView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            formView.centerXAnchor.constraint(equalTo: bluredView!.centerXAnchor),
            formView.centerYAnchor.constraint(equalTo: bluredView!.centerYAnchor),
            formView.widthAnchor.constraint(equalTo: bluredView!.widthAnchor, multiplier: 0.9),
            formView.heightAnchor.constraint(equalTo: bluredView!.heightAnchor, multiplier: 0.3)
            ])
    }
    
    func setupAdditionalConfigurantion() {
        formView.backgroundColor = .white
    }
    
    
}

extension NewGoalViewController: FormViewDelegate {
    
    func dismissNewGoalModal() {
        dismiss(animated: true, completion: nil)
    }
}
