//
//  AddGoalsAnimator.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 12/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit

enum TransitionType{
    case presenting
    case dismissing
}

class AddGoalsAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var transitionType: TransitionType!
    
    
    init(transitionType: TransitionType) {
        super.init()
        self.transitionType = transitionType
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch transitionType {
        case .presenting:
            present(using: transitionContext)
        case .dismissing:
            dismiss(using: transitionContext)
        case .none:
            break
        }
    }
    
    
    func dismiss(using transitionContext: UIViewControllerContextTransitioning){
        //getting references
        guard let fromVC = transitionContext.viewController(forKey: .from) as? NewGoalViewController,
            let toVC = transitionContext.viewController(forKey: .to) else {
                return
        }
        //
        let containerView = transitionContext.containerView
        //setting toVC
        
        //
        containerView.addSubview(fromVC.view)
        
        //
        let duration = transitionDuration(using: transitionContext)
        
        
        
        UIView.animate(withDuration: 8*duration/10,
                       delay: 0,
                       animations: {
                        fromVC.formView.transform = CGAffineTransform.init(scaleX: 0.001, y: 0.001)
        })
        { (completed) in
            UIView.animate(withDuration: 2*duration/10,
                           delay: 0,
                           animations: {
                            fromVC.view.alpha = 0
            })
            { (completed) in
                transitionContext.completeTransition(
                    !transitionContext.transitionWasCancelled)
            }
        }
    }
    
    func present(using transitionContext: UIViewControllerContextTransitioning){
        //getting references
               guard let fromVC = transitionContext.viewController(forKey: .from),
                   let toVC = transitionContext.viewController(forKey: .to) as? NewGoalViewController else {
                       return
               }
               
               //
               let containerView = transitionContext.containerView
               //setting toVC
               toVC.view.frame = CGRect(x: 0, y: 0, width: fromVC.view.frame.size.width, height: fromVC.view.frame.size.height)
               toVC.view?.alpha = 0
               toVC.formView.transform = CGAffineTransform(scaleX: 0, y: 0)
               
               let fromSnapshotView = fromVC.view.resizableSnapshotView(from: fromVC.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsets())
               
               //
               containerView.addSubview(fromSnapshotView!)
               containerView.addSubview(toVC.view)
               
               
               //
               let duration = transitionDuration(using: transitionContext)
               UIView.animate(withDuration: 2*duration/10,
                              delay: 0,
                              animations: {
                               toVC.view?.alpha = 1
                               
               })
               { (completed) in
                   UIView.animate(withDuration: 8*duration/10,
                                  delay: 0,
                                  usingSpringWithDamping: 0.8,
                                  initialSpringVelocity: 0.01,
                                  options: .curveEaseInOut,
                                  animations: {
                                   toVC.formView.transform = CGAffineTransform(scaleX: 1, y: 1)
                                   //
                                       
                   })
                   { (completed) in
                       transitionContext.completeTransition(
                           !transitionContext.transitionWasCancelled)
                   }
               }
    }
}
