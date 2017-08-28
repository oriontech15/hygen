//
//  QuadsTableViewCell.swift
//  DHS
//
//  Created by Justin Smith on 8/14/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

protocol QuadsCellDelegate {
    func quadsUpdated(quads: Int)
}

class QuadsTableViewCell: UITableViewCell, UITextFieldDelegate, CheckQuadsDataDelegate {

    var firstLoad: Bool = true
    var changesMade: Bool = false
    var saveButtonUsed: Bool = false
    
    @IBOutlet weak var quadsTextField: UITextField!
    
    var quads: Int?
    
    var patient: Patient!
    
    var delegate: QuadsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        quadsTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        addDoneButtonOnKeyboard()
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barTintColor = AppearanceController.shared.mainColor.withAlphaComponent(0.8)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Dismiss", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneButtonAction))
        done.tintColor = .white
        
        var items: [UIBarButtonItem] = []
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.quadsTextField.inputAccessoryView = doneToolbar
    }
    
    func doneButtonAction()
    {
        self.quadsTextField.resignFirstResponder()
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if let quads = Int(textField.text!) {
            self.delegate?.quadsUpdated(quads: quads)
        }
    }
    
    func updateWith(patient: Patient, editable: Bool) {
        updateEditable(editable: editable)
        self.quadsTextField.text = "\(patient.quads)"
    }
    
    func getData() -> Int? {
        if let quads = Int(quadsTextField.text!) {
            return quads
        } else {
            return nil
        }
    }
    
    func updateEditable(editable: Bool) {
        if !editable {
            self.quadsTextField.isUserInteractionEnabled = false
            self.quadsTextField.backgroundColor = UIColor.myLightGray()
            self.contentView.backgroundColor = UIColor.myLightGray()
        } else {
            self.quadsTextField.isUserInteractionEnabled = true
            self.quadsTextField.backgroundColor = .white
            self.contentView.backgroundColor = UIColor.white
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let quads = Int(textField.text!) {
            self.quads = quads
            self.delegate?.quadsUpdated(quads: quads)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
