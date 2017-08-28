//
//  GradientView.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

//@IBDesignable
class GradientView: UIView, CAAnimationDelegate {
    
    var gradient : CAGradientLayer!
    var fromColors: [CGColor]! {
        didSet {
            animateLayer()
        }
    }
    var toColors: [CGColor]! {
        didSet {
            animateLayer()
        }
    }
    
    var from: [CGColor]!
    var to: [CGColor]!
    
    var className: RequirementType = .class1A
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.gradient = CAGradientLayer()
        self.gradient?.frame = self.bounds
        self.from = AppearanceController.shared.semiAlphaGradientColors
        self.to = AppearanceController.shared.almostAlphaGradientColors
        self.gradient?.colors = AppearanceController.shared.semiAlphaGradientColors
        self.layer.insertSublayer(self.gradient, at: 0)
        
        animateLayer()
    }
    
    func animateLayer() {
        
        from = self.gradient?.colors as! [CGColor]
        if fromColors != nil {
            self.from = fromColors
        }
        if toColors != nil {
            self.to = toColors
        }
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
        
        animation.fromValue = from
        animation.toValue = to
        animation.duration = 1.50
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.autoreverses = true
        animation.repeatCount = HUGE
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.delegate = self
        
        self.gradient?.add(animation, forKey:"animateGradient")
    }
}
