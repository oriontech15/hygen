//
//  ToothView.swift
//  DHS
//
//  Created by Justin Smith on 8/11/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ToothView: UIView {

    override func draw(_ rect: CGRect) {
        // Drawing code
        ToothStyleKit.drawTooth(frame: self.bounds, resizing: .aspectFit)
    }
}
