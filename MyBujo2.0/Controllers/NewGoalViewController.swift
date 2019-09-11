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
    var effect: UIVisualEffect?
    var visualEffect: UIVisualEffectView?
    let formView = FormView()
    weak var delegate: NewGoalViewControllerDelegate!
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        visualEffect = addBlur()
        effect = visualEffect?.effect
        visualEffect?.effect = nil
        bluredView = visualEffect?.contentView
        setupView()
        formView.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(shouldDismissModal))
        bluredView?.addGestureRecognizer(tapGesture)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        animateIn(view: formView, visualEffect: visualEffect!, effect: effect!)
    }
    
    // MARK: Functions
    func buildViewHierarchy() {
        view.addSubview(formView)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            formView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            formView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
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
        self.animateOut(view: self.view, visualEffect: self.visualEffect!)
    }
    
    func didPressDone(descript: String?) {
        if descript != ""{
            let goal = Goal(context: CoreDataManager.context)
            goal.descript = descript
            goal.completed = false
            CalendarManager.shared.selectedDay.addToGoals(goal)
            CalendarManager.shared.selectedDay.save()
            self.delegate.didDismissWithDescript()
            self.animateOut(view: self.view, visualEffect: self.visualEffect!)
        } else {
            self.delegate.didDismissWithoutDescript()
            self.animateOut(view: self.view, visualEffect: self.visualEffect!)
        }
        
    }
}
