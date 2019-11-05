//
//  BlurableModalAnimationController.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 11/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation
import UIKit

class BlurableModalAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let originFrame: CGRect
    
    init(originFrame: CGRect) {
        self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
			let _ = toVC.view.snapshotView(afterScreenUpdates: true)
            else {
                return
            }
        
        
        transitionContext.containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            fromVC.view.alpha = 0
        }) { _ in
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    
}
