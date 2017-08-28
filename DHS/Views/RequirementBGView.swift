//
//  RequirementBGView.swift
//  DHS
//
//  Created by Justin Smith on 6/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

//@IBDesignable
class RequirementBGView: UIView {
        
    var requirementType: RequirementType = .defaultClass {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        switch self.requirementType {
        case .class1A:
            StyleKit.drawRequirementBackgroundPurple(frame: self.bounds)
            break
        case .class1B:
            StyleKit.drawRequirementBackgroundOrange(frame: self.bounds)
            break
        case .class2:
            StyleKit.drawRequirementBackgroundGreen(frame: self.bounds)
            break
        case .class3:
            StyleKit.drawRequirementBackgroundBlue(frame: self.bounds)
            break
        case .class4:
            StyleKit.drawRequirementBackgroundRed(frame: self.bounds)
            break
        case .class5:
            StyleKit.drawRequirementBackgroundYellow(frame: self.bounds)
            break
        case .defaultClass:
            break
        case .pano:
            StyleKit.drawRequirementBackgroundDefault(frame: self.bounds)
            break
        case .bwx:
            StyleKit.drawRequirementBackgroundDefault(frame: self.bounds)
            break
        case .pa:
            StyleKit.drawRequirementBackgroundDefault(frame: self.bounds)
            break
        case .injection:
            StyleKit.drawRequirementBackgroundDefault(frame: self.bounds)
            break
        }
    }
}
