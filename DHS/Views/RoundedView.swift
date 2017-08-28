//
//  RoundedView.swift
//  DHS
//
//  Created by Justin Smith on 7/19/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat? {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        if let cornerRadius = self.cornerRadius {
            self.layer.cornerRadius = cornerRadius
        } else {
            self.layer.cornerRadius = self.frame.height / 2
        }
    }
}

