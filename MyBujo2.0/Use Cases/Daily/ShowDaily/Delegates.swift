//
//  Delegates.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 02/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit

extension MyTodayViewController:TableViewHeaderViewDelegate {
    func addGoal() {
        let newGoalViewController = NewGoalViewController()
        newGoalViewController.delegate = self
//        newGoalViewController.transitioningDelegate = self
//        newGoalViewController.modalPresentationStyle = .overCurrentContext
        present(newGoalViewController, animated: true, completion: nil)
    }
}

extension MyTodayViewController: MediaCollectionViewDelegate {
    func pushMediaController(viewController: UIViewController) {
		navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MyTodayViewController: NewGoalViewControllerDelegate {
    func didDismissWithDescript() {
//        tableView.reloadData()
		tableView.reloadData()
    }
    
    func didDismissWithoutDescript() {
        //
    }
}

extension MyTodayViewController: NewFeelingViewControllerDelegate {
    func didAddFeeling(date: Date) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CalendarTableViewCell else { return }
        cell.calendarView.reloadData(withAnchor: date, completionHandler: nil)
    }
}

//extension MyTodayViewController: UIViewControllerTransitioningDelegate {
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if presented as? NewBaseViewController != nil {
//            return AddGoalsAnimator(transitionType: .presenting)
//        }
//        return nil
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if dismissed as? NewBaseViewController != nil {
//            return AddGoalsAnimator(transitionType: .dismissing)        }
//        return nil
//    }
//}
