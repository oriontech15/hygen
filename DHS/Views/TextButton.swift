//
//  TextButton.swift
//  DHS
//
//  Created by Justin Smith on 8/14/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class TextButton: UIButton {
    
    var hasText: Bool = false
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        if hasText {
            switch AppearanceController.shared.mainColorName {
            case .purple:
                StyleKit.drawPurpleText(frame: self.bounds, resizing: .aspectFit)
                break
            case .orange:
                StyleKit.drawOrangeText(frame: self.bounds, resizing: .aspectFit)
                break
            case .green:
                StyleKit.drawGreenText(frame: self.bounds, resizing: .aspectFit)
                break
            case .blue:
                StyleKit.drawBlueText(frame: self.bounds, resizing: .aspectFit)
                break
            case .red:
                StyleKit.drawRedText(frame: self.bounds, resizing: .aspectFit)
                break
            case .yellow:
                StyleKit.drawYellowText(frame: self.bounds, resizing: .aspectFit)
                break
            case .pink:
                StyleKit.drawPinkText(frame: self.bounds, resizing: .aspectFit)
            case .white:
                break
            }
        } else {
            StyleKit.drawNoTextButton(frame: self.bounds, resizing: .aspectFit)
        }
    }
}
