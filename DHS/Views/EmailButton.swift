//
//  EmailButton.swift
//  DHS
//
//  Created by Justin Smith on 8/14/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

@IBDesignable
class EmailButton: UIButton {
    
    var hasEmail: Bool = false {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        self.imageView?.contentMode = .scaleAspectFit;
        
        if hasEmail {
            
            switch AppearanceController.shared.mainColorName {
            case .purple:
                self.setImage(#imageLiteral(resourceName: "PurpleMail"), for: .normal)
                break
            case .orange:
                self.setImage(#imageLiteral(resourceName: "OrangeMail"), for: .normal)
                break
            case .green:
                self.setImage(#imageLiteral(resourceName: "GreenMail"), for: .normal)
                break
            case .blue:
                self.setImage(#imageLiteral(resourceName: "BlueMail"), for: .normal)
                break
            case .red:
                self.setImage(#imageLiteral(resourceName: "RedMail"), for: .normal)
                break
            case .yellow:
                self.setImage(#imageLiteral(resourceName: "YellowMail"), for: .normal)
                break
            case .pink:
                self.setImage(#imageLiteral(resourceName: "PinkMail"), for: .normal)
                break
            case .white:
                break
            }
        } else {
            self.setImage(#imageLiteral(resourceName: "NoEmailButton"), for: .normal)
        }
    }
}
