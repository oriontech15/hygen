//
//  CustomButton.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    var active: Bool = true {
        didSet {
            changeActive()
        }
    }

    override func awakeFromNib() {
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
    }
    
    func changeActive() {
        if active {
            self.backgroundColor = AppearanceController.shared.mainColor
            self.isEnabled = true
        } else {
            self.backgroundColor = UIColor.myLightGray()
            self.isEnabled = false
        }
    }

}
