//
//  NumPad.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

protocol NumPadDelegate {
    func numPadFinished(total: Int?)
}

@IBDesignable
class NumPad: UIView {
    
    var delegate: NumPadDelegate?
    
    @IBOutlet weak var totalLabel: UILabel! {
        didSet {
            if totalLabel.text == "" {
                self.totalLabel.text = "0"
            }
        }
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        if sender.tag != 10 {
            if totalLabel.text != "0" {
                self.totalLabel.text! += "\(sender.tag)"
            } else {
                self.totalLabel.text = ""
                self.totalLabel.text! += "\(sender.tag)"
            }
        } else {
            let text = totalLabel.text ?? "0"
            let newValue = text.substring(to: text.index(before: text.endIndex))
            totalLabel.text = String(describing: newValue)
        }
    }
    
    @IBAction func doneButtonTapped() {
        if totalLabel.text != "" || totalLabel.text != nil {
            self.delegate?.numPadFinished(total: Int(totalLabel.text!)!)
            self.totalLabel.text = "0"
        } else {
            self.totalLabel.text = "0"
            self.delegate?.numPadFinished(total: Int(totalLabel.text!)!)
        }
    }
    
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
    }
    
    func xibSetup() {
        self.layer.cornerRadius = 22
        self.layer.masksToBounds = true
    }
}

extension UIView {
    class func fromNib<T : UIView>(name: String) -> T {
        return Bundle.main.loadNibNamed(String(describing: name), owner: nil, options: nil)![0] as! T
    }
}
