//
//  ColorButton.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

protocol ColorPickerDelegate {
    func colorPicked(color: UIColor)
}

//@IBDesignable
class ColorButton: UIButton {
    
    var delegate: ColorPickerDelegate?

    @IBInspectable var color: UIColor = .white
    
    @IBInspectable var colorID: Int = 0 {
        didSet {
            switch colorID {
            case 0:
                self.colorName = .red
                break
            case 1:
                self.colorName = .orange
                break
            case 2:
                self.colorName = .yellow
                break
            case 3:
                self.colorName = .green
                break
            case 4:
                self.colorName = .blue
                break
            case 5:
                self.colorName = .purple
                break
            case 6:
                self.colorName = .pink
            default:
                break
            }
        }
    }
    
    var colorName: MainColorName = MainColorName.white
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2.0
    }
    
    func notSelected() {
        self.layer.borderWidth = 0
    }
    
    func selected() {
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1.00).cgColor
        self.delegate?.colorPicked(color: self.color)
        UserController.shared.updateColor(colorName: colorName.rawValue)
        AppearanceController.shared.mainColor = color
        AppearanceController.shared.mainColorName = colorName
    }
    
    func setupButton() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        switch colorID {
        case 0:
            self.color = UIColor.myRed()
            break
        case 1:
            self.color = UIColor.myOrange()
            break
        case 2:
            self.color = UIColor.myYellow()
            break
        case 3:
            self.color = UIColor.myGreen()
            break
        case 4:
            self.color = UIColor.myBlue()
            break
        case 5:
            self.color = UIColor.myPurple()
            break
        case 6:
            self.color = UIColor.myPink()
        default:
            break
        }
        self.backgroundColor = color
    }
}
