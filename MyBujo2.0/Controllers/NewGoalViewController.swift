//
//  NewGoalViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 28/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.

import UIKit


class NewGoalViewController: UIViewController, ViewCode, Blurable {
    
    // MARK: Properties
    var bluredView: UIView?
    let formView = FormView()
    var delegate: NewGoalViewControllerDelegate!
    
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        bluredView = addBlur()
        setupView()
        formView.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(shouldDismissModal))
        bluredView?.addGestureRecognizer(tapGesture)
    }
    
    
    // MARK: Functions
    func buildViewHierarchy() {
        view.addSubview(formView)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            formView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            formView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            formView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            formView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
            ])
    }
    func setupAdditionalConfigurantion() {
        formView.backgroundColor = .white
    }
}


    // MARK: Extension
extension NewGoalViewController: FormViewDelegate {
    
    @objc func shouldDismissModal() {
        dismiss(animated: true, completion: nil)
    }
    
    func didPressDone(descript: String?) {
        if descript != ""{
            let goal = Goal(context: CoreDataManager.context)
            goal.descript = descript
            goal.completed = false
            CalendarManager.shared.selectedDay.addToGoals(goal)
            CalendarManager.shared.selectedDay.save()
            dismiss(animated: true, completion: {
                self.delegate.didDismissWithDescript()
            })
        } else {
            dismiss(animated: true, completion: {
                self.delegate.didDismissWithoutDescript()
            })
        }
        
    }
}
