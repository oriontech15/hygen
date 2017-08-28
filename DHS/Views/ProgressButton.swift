//
//  ProgressButton.swift
//  DHS
//
//  Created by Justin Smith on 6/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ProgressButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
//        setImage(AppearanceController.shared.progressButtonImage, for: .normal)
//        self.imageView!.contentMode = .scaleAspectFit
    }
    
    override func draw(_ rect: CGRect) {
        setImage(AppearanceController.shared.progressButtonImage, for: .normal)
        self.imageView!.contentMode = .scaleAspectFit
    }
}
