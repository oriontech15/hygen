//
//  TabBarView.swift
//  DHS
//
//  Created by Justin Smith on 8/11/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class TabBarView: UIView {
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        StyleKit.drawTabBarBG(frame: self.bounds, resizing: .aspectFit)
    }
}
