//
//  CustomNumButton.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

//@IBDesignable
class CustomNumButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 32.5 {
        didSet {
            setupButton()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    func setupButton() {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        self.setTitleColor(.white, for: .normal)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupButton()
    }
}
