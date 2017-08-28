//
//  CalendarButton.swift
//  DHS
//
//  Created by Justin Smith on 6/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class CalendarButton: UIButton {
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setImage(#imageLiteral(resourceName: "Cal"), for: .normal)
        self.imageView!.contentMode = .scaleAspectFit
    }
}
