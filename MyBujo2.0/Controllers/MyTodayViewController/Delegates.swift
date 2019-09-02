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
        guard let customSplitViewController = splitViewController as? CustomSplitViewController else { return }
        let viewCont = customSplitViewController.controllers[1]
        viewCont.definesPresentationContext = true
        
        let newGoalViewController = NewGoalViewController()
        newGoalViewController.day = day
        newGoalViewController.delegate = self
        newGoalViewController.modalPresentationStyle = .overCurrentContext
        viewCont.present(newGoalViewController, animated: true, completion: nil)
    }
}

extension MyTodayViewController: MediaCollectionViewDelegate {
    func pushViewController(viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
}

extension MyTodayViewController: CalendarTableViewCellDelegate {
    func shouldShowAddFeelingModal() {
        guard let customSplitViewController = splitViewController as? CustomSplitViewController else { return }
        let viewCont = customSplitViewController.controllers[1]
        viewCont.definesPresentationContext = true
        
        let newFeelingViewController = NewFeelingViewController()
        newFeelingViewController.modalPresentationStyle = .overCurrentContext
        viewCont.present(newFeelingViewController, animated: true, completion: nil)
    }
    
    /// Solve Later
    func didSelectDate(date: Date) {
        //do something

        let result = CoreDataManager.fetch(entityClass: Day.self,predicate: EntityType.day(date).predicate)
        guard let day = result?.first as? Day else {
            self.day = Day(context: CoreDataManager.context)
            guard let dateIgnoringTime = date.ignoringTime() else { return }
            self.day.date = dateIgnoringTime
            self.day.save()
            return
        }
        self.day = day
        
    }
}

extension MyTodayViewController: NewGoalViewControllerDelegate{
    func didDismissWithDescript() {
        tableView.reloadData()
    }
    
    func didDismissWithoutDescript() {
        //
    }
}
