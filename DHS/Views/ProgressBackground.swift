//
//  ProgressBackground.swift
//  DHS
//
//  Created by Justin Smith on 8/11/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

@IBDesignable
class ProgressBackground: UIView {

    override func draw(_ rect: CGRect) {
        // Drawing code
        StyleKit.drawProgressBackgroundNew(frame: self.bounds, resizing: .aspectFit)
    }
}
