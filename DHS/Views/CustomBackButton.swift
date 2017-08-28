//
//  CustomBackButton.swift
//  DHS
//
//  Created by Justin Smith on 6/13/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class CustomBackButton: UIButton {
    
    var className: RequirementType = .defaultClass
    
    override func draw(_ rect: CGRect) {
        switch className {
        case .class1A:
            StyleKit.drawBackButtonPurple(frame: self.bounds, resizing: .center)
            break
        case .class1B:
            StyleKit.drawBackButtonOrange(frame: self.bounds, resizing: .center)
            break
        case .class2:
            StyleKit.drawBackButtonGreen(frame: self.bounds, resizing: .center)
            break
        case .class3:
            StyleKit.drawBackButtonBlue(frame: self.bounds, resizing: .center)
            break
        case .class4:
            StyleKit.drawBackButtonRed(frame: self.bounds, resizing: .center)
            break
        case .class5:
            StyleKit.drawBackButtonYellow(frame: self.bounds, resizing: .center)
            break
        case .defaultClass:
            StyleKit.drawBackButtonPink(frame: self.bounds, resizing: .center)
        default:
            break
        }
    }
}
