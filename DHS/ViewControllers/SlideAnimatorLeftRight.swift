//
//  SlideAnimator.swift
//  DHS
//
//  Created by Justin Smith on 8/10/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import UIKit

class SlideAnimatorLeftRight: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    let duration = 0.8
    var left: Bool = false
    
    init(left: Bool) {
        self.left = left
    }
    
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
        
        let screenOffRight: CGAffineTransform!
        let screenOffLeft : CGAffineTransform!
        
        if left {
            screenOffRight = CGAffineTransform(translationX: -container.frame.width, y: 0)
            screenOffLeft = CGAffineTransform(translationX: container.frame.width, y: 0)
        } else {
            screenOffRight = CGAffineTransform(translationX: -container.frame.width, y: 0)
            screenOffLeft = CGAffineTransform(translationX: container.frame.width, y: 0)
        }
        
        container.addSubview(fromView)
        container.addSubview(toView)
        
        if left {
            toView.transform = screenOffRight
        } else {
            toView.transform = screenOffLeft
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            
            if self.left {
                fromView.transform = screenOffLeft
            } else {
                fromView.transform = screenOffRight
            }
            
            fromView.alpha = 0.4
            toView.transform = CGAffineTransform.identity
            toView.alpha = 1.0
            
        }) { (success) in
            transitionContext.completeTransition(success)
        }
    }
}
