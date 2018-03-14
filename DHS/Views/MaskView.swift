//
//  MaskView.swift
//  DHS
//
//  Created by Justin Smith on 3/14/18.
//  Copyright © 2018 com.example. All rights reserved.
//

import UIKit

class MaskView: UIView {
    
    @IBInspectable var topLeftCorner: Bool = false {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var topRightCorner: Bool = false {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var bottomLeftCorner: Bool = false {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var bottomRightCorner: Bool = false {
        didSet {
            setupView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        let corners = ["topLeft" : topLeftCorner, "topRight" : topRightCorner, "bottomLeft" : bottomLeftCorner, "bottomRight" : bottomRightCorner]
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornersToUpdate(corners: corners), cornerRadii: CGSize(width: 4, height: 4)).cgPath
        
        //Here I'm masking the textView's layer with rectShape layer
        self.layer.mask = rectShape
    }

    private func cornersToUpdate(corners: [String : Bool]) -> UIRectCorner {
        var cornersToUpdate: UIRectCorner = []
        for corner in corners.keys {
            if corners[corner] == true {
                switch corner {
                case "topLeft":
                    cornersToUpdate.insert(.topLeft)
                case "topRight":
                    cornersToUpdate.insert(.topRight)
                case "bottomLeft":
                    cornersToUpdate.insert(.bottomLeft)
                case "bottomRight":
                    cornersToUpdate.insert(.bottomRight)
                default:
                    break
                }
            }
        }
        return cornersToUpdate
    }
}
