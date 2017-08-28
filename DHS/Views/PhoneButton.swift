//
//  PhoneButton.swift
//  DHS
//
//  Created by Justin Smith on 8/14/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

@IBDesignable
class PhoneButton: UIButton {
    
    var hasPhone: Bool = false
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        if hasPhone {
            switch AppearanceController.shared.mainColorName {
            case .purple:
                StyleKit.drawPurplePhone(frame: self.bounds, resizing: .aspectFit)
                break
            case .orange:
                StyleKit.drawOrangePhone(frame: self.bounds, resizing: .aspectFit)
                break
            case .green:
                StyleKit.drawGreenPhone(frame: self.bounds, resizing: .aspectFit)
                break
            case .blue:
                StyleKit.drawBluePhone(frame: self.bounds, resizing: .aspectFit)
                break
            case .red:
                StyleKit.drawRedPhone(frame: self.bounds, resizing: .aspectFit)
                break
            case .yellow:
                StyleKit.drawYellowPhone(frame: self.bounds, resizing: .aspectFit)
                break
            case .pink:
                StyleKit.drawPinkPhone(frame: self.bounds, resizing: .aspectFit)
                break
            case .white:
                break
            }
        } else {
            StyleKit.drawNoPhoneButton(frame: self.bounds, resizing: .aspectFit)
        }
    }
}
