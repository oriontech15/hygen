//
//  CustomRequirementTextField.swift
//  DHS
//
//  Created by Justin Smith on 6/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class CustomRequirementTextField: UITextField, UITextFieldDelegate {
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.text = ""
    }
}
