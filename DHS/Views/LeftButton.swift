//
//  LeftButton.swift
//  DHS
//
//  Created by Justin Smith on 7/21/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class LeftButton: UIButton {

    @IBInspectable var left: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        if left {
            StyleKit.drawLeftButton(frame: self.bounds, resizing: .center)
        } else {
            StyleKit.drawRightButton(frame: self.bounds, resizing: .center)
        }
    }
}
