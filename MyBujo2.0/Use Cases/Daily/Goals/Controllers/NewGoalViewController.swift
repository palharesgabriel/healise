//
//  NewGoalViewController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 28/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.

import UIKit


class NewGoalViewController: UIViewController, ViewCode {
    // MARK: Properties
    let formView = FormView()
    weak var delegate: NewGoalViewControllerDelegate!
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        formView.delegate = self
    }
    
    
    // MARK: Functions
    func buildViewHierarchy() {
        view.addSubview(formView)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            formView.topAnchor.constraint(equalTo: view.topAnchor),
            formView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            formView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            formView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    func setupAdditionalConfigurantion() {
        formView.backgroundColor = .white
    }

}


    // MARK: Extension
extension NewGoalViewController: FormViewDelegate {
    @objc func didPressDone(descript: String?) {
        dismiss(animated: true, completion: {
            if descript != ""{
                let goal = Goal(context: CoreDataManager.context)
                goal.descript = descript
                goal.completed = false
                CalendarManager.shared.selectedDay.addToGoals(goal)
                CalendarManager.shared.selectedDay.save()
                self.delegate.didDismissWithDescript()
            } else {
                self.delegate.didDismissWithoutDescript()
            }
        })
        
    }
}
