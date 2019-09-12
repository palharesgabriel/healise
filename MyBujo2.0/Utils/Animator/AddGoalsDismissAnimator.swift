//
//  AddGoalsAnimator.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 12/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit
class AddGoalsDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
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
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 4/5) {
                fromVC.formView.frame = fromVC.formView.frame.offsetBy(dx: 0, dy: toVC.view.frame.height + fromVC.formView.frame.height)
            }
            UIView.addKeyframe(withRelativeStartTime: 1/5, relativeDuration: 1/5) {
                
                fromVC.view?.alpha = 0
            }
        })
        { (isSuccessful) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
