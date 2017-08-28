//
//  TabView.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

@IBDesignable
class TabView: UIView {
    
    override func draw(_ rect: CGRect) {
        StyleKit.drawTabTop(frame: self.bounds, resizing: .stretch)
    }
}
