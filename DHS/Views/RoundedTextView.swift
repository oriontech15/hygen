//
//  RoundedTextField.swift
//  DHS
//
//  Created by Justin Smith on 8/14/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedTextView: UITextView {

    @IBInspectable var cornerRadius: CGFloat? {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
            self.layer.cornerRadius = 7
        }
    }
}
