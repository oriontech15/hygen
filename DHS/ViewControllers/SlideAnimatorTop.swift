//
//  SlideAnimator.swift
//  DHS
//
//  Created by Justin Smith on 8/10/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import UIKit

class SlideAnimatorTop: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    let duration = 0.8
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        let container = transitionContext.containerView
        
        let screenOffUp = CGAffineTransform(translationX: 0, y: container.frame.height)
        let screenOffDown = CGAffineTransform(translationX: 0, y: -container.frame.height)
        
        container.addSubview(fromView)
        container.addSubview(toView)
        
        toView.transform = screenOffUp
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            
            fromView.transform = screenOffDown
            fromView.alpha = 0.4
            toView.transform = CGAffineTransform.identity
            toView.alpha = 1.0
            
        }) { (success) in
            transitionContext.completeTransition(success)
        }
    }
}
