//
//  ClassSelectButton.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

//@IBDesignable
class ClassSelectButton: UIButton {
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    var currentSelected: RequirementType = .defaultClass
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    
    func notSelected() {
        self.backgroundColor = .clear
    }
    
    func selected() {
        self.backgroundColor = UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1.0)
    }
    
    override func draw(_ rect: CGRect) {
        switch self.tag {
        case 0:
            StyleKit.drawClassBackgroundPurple(frame: self.bounds, resizing: .aspectFit)
            self.currentSelected = .class1A
            break
        case 1:
            StyleKit.drawClassBackgroundOrange(frame: self.bounds, resizing: .aspectFit)
            self.currentSelected = .class1B
            break
        case 2:
            StyleKit.drawClassBackgroundGreen(frame: self.bounds, resizing: .aspectFit)
            self.currentSelected = .class2
            break
        case 3:
            StyleKit.drawClassBackgroundBlue(frame: self.bounds, resizing: .aspectFit)
            self.currentSelected = .class3
            break
        case 4:
            StyleKit.drawClassBackgroundRed(frame: self.bounds, resizing: .aspectFit)
            self.currentSelected = .class4
            break
        case 5:
            StyleKit.drawClassBackgroundYellow(frame: self.bounds, resizing: .aspectFit)
            self.currentSelected = .class5
            break
        default:
            break
        }
    }
}
