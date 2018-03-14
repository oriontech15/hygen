//
//  ShadowView.swift
//  DHS
//
//  Created by Justin Smith on 3/14/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 1.2
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 4).cgPath
        //self.layer.shouldRasterize = true
    }

}
