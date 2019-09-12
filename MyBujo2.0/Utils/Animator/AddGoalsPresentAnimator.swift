//
//  AddGoalsAnimator.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 12/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit
class AddGoalsPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
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
        
        
        
        
        let fromSnapshotView = fromVC.view.resizableSnapshotView(from: fromVC.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsets())
        
        //
        containerView.addSubview(fromSnapshotView!)
        containerView.addSubview(toVC.view)
        
        let origin = CGRect(x: toVC.view.frame.midX, y: toVC.formView.frame.origin.y + toVC.view.frame.height * 0.15 + 32, width: toVC.formView.frame.width, height: toVC.formView.frame.height)
        toVC.formView.frame = origin.offsetBy(dx: 0, dy: toVC.view.frame.height + toVC.view.frame.height * 0.15)

        //
        let duration = transitionDuration(using: transitionContext)
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/5) {
                toVC.view?.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 1/5, relativeDuration: 4/5) {
                toVC.formView.frame = origin
            }
        })
        { (isSuccessful) in
            fromSnapshotView?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
