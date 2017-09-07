//
//  InjectionsTableViewCell.swift
//  DHS
//
//  Created by Justin Smith on 8/14/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

protocol InjectionsCellDelegate {
    func injectionsUpdated(injectionsOn: Bool, injections: Int)
    func injectionsOnUpdated()
}

class InjectionsTableViewCell: UITableViewCell, UITextFieldDelegate, CheckInjectionDataDelegate {

    var firstLoad: Bool = true
    var changesMade: Bool = false
    var saveButtonUsed: Bool = false
    
    @IBOutlet weak var injectionsTextField: UITextField!
    @IBOutlet weak var injectionsLabel: UILabel!
    @IBOutlet weak var injectionsSwitch: UISwitch!
    
    @IBOutlet weak var injectionsStackView: UIStackView!
    
    var injectionsNumber: Int?
    
    var delegate: InjectionsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        injectionsTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
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
        
        self.injectionsTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.injectionsTextField.resignFirstResponder()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let injectionNumber = Int(textField.text!) {
            self.delegate?.injectionsUpdated(injectionsOn: self.injectionsSwitch.isOn, injections: injectionNumber)
        }
    }
    
    func updateWith(patient: Patient, editable: Bool) {
        self.injectionsSwitch.isOn = patient.injectionsOn
        self.injectionsTextField.text = "\(patient.injections)"
        self.injectionsSwitchUpdated(sender: self.injectionsSwitch)
        updateEditable(editable: editable)
    }
    
    func getData() -> (injectionOn: Bool, injections: Int?) {
        if let injectionNumber = Int(self.injectionsTextField.text!) {
            return (self.injectionsSwitch.isOn, injectionNumber)
        } else {
            return (self.injectionsSwitch.isOn, nil)
        }
    }
    
    func updateEditable(editable: Bool) {
        if !editable {
            self.injectionsSwitch.isUserInteractionEnabled = false
            self.injectionsTextField.isUserInteractionEnabled = false
            self.injectionsTextField.backgroundColor = UIColor.myLightGray()
            self.contentView.backgroundColor = UIColor.myLightGray()
        } else {
            self.injectionsSwitch.isUserInteractionEnabled = true
            self.injectionsTextField.isUserInteractionEnabled = true
            self.injectionsTextField.backgroundColor = .white
            self.contentView.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func injectionsSwitchUpdated(sender: UISwitch) {
        if sender.isOn {
            self.injectionsTextField.isHidden = false
            self.injectionsLabel.isHidden = false
        } else {
            self.injectionsTextField.isHidden = true
            self.injectionsLabel.isHidden = true
        }
        self.delegate?.injectionsOnUpdated()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let injectionNumber = Int(textField.text!) {
            self.injectionsNumber = injectionNumber
            self.delegate?.injectionsUpdated(injectionsOn: self.injectionsSwitch.isOn, injections: injectionNumber)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
