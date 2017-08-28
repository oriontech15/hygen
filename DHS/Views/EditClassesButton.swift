//
//  EditClassesButton.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

//@IBDesignable
class EditClassesButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        StyleKit.drawEditClasses(frame: self.bounds, resizing: .aspectFit)
    }
}
