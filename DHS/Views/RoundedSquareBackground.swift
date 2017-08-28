//
//  RoundedSquareBackground.swift
//  DHS
//
//  Created by Justin Smith on 8/15/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class RoundedSquareBackground: UIView {

    override func draw(_ rect: CGRect) {
        // Drawing code
        StyleKit.drawProgressBackgroundSquare(frame: self.bounds, resizing: .aspectFit)
    }
}
