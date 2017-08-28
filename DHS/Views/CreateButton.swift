//
//  CreateButton.swift
//  DHS
//
//  Created by Justin Smith on 6/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

//@IBDesignable
class CreateButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        setImage(AppearanceController.shared.createButtonImage, for: .normal)
//        self.imageView!.contentMode = .scaleAspectFit
    }
    
    override func draw(_ rect: CGRect) {
        setImage(AppearanceController.shared.createButtonImage, for: .normal)
        self.imageView!.contentMode = .scaleAspectFit
    }
    
}
