//
//  NewGoalViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 28/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class FormView: UIView, Shadow {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NewGoalViewController: UIViewController, ViewCode, Blurable {    
    var bluredView: UIView?

    let formView = FormView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bluredView = addBlur()
        setupView()
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
