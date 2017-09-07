//
//  XrayTableViewCell.swift
//  DHS
//
//  Created by Justin Smith on 8/14/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class XrayTableViewCell: UITableViewCell, UITextFieldDelegate, CheckXrayDataDelegate {
    
    @IBOutlet weak var xraySwitch: UISwitch!
    
    @IBOutlet weak var xrayOptionsStack: UIStackView!
    @IBOutlet weak var typeStack: UIStackView!
    
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!
    @IBOutlet weak var typeSegmentedControl: CustomSegmentedControl!
    @IBOutlet weak var setsSegmentedControl: CustomSegmentedControl!
    
    @IBOutlet weak var setsStack: UIStackView!
    @IBOutlet weak var nPAStack: UIStackView!
    @IBOutlet weak var typeStackView: UIStackView!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var nPALabel: UILabel!
    
    @IBOutlet weak var leftXrayRequirementView: UIView!
    @IBOutlet weak var rightXrayRequirementView: UIView!
    @IBOutlet weak var leftXrayTypeView: UIView!
    @IBOutlet weak var rightXrayTypeView: UIView!
    @IBOutlet weak var leftPaView: UIView!
    @IBOutlet weak var rightPaView: UIView!
    @IBOutlet weak var leftSetsView: UIView!
    @IBOutlet weak var rightSetsView: UIView!
    @IBOutlet weak var paTextFieldBackgroundView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var originalXrayType: Int?
    var originalXray: Int?
    var originalSets: Int?
    var originalPaNumber: Int?
    
    var selectedIndex: Int = 0
    
    let panoItems = ["CBCT", "Scan-x"]
    let bwxItems = ["Schick", "Scan-x"]
    let paItems = ["Schick", "Scan-x"]
    
    var xrayRequirement: xRayRequirement? {
        didSet {
            print("xRayRequirement - Updated!")
        }
    }
    var xrayType: xRayType? {
        didSet {
            print("xRayType - Updated!")
        }
    }
    var paNumber: Int? {
        didSet {
            print("Pa Number - Updated!")
        }
    }
    var sets: Int? {
        didSet {
            print("Sets - Updated!")
        }
    }
    
    var patient: Patient!
    
    var delegate: XrayCellDelegate?
    
    var firstLoad: Bool = true
    var changesMade: Bool = false
    var saveButtonUsed: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
        
        self.numberTextField.inputAccessoryView = doneToolbar
        self.numberTextField.delegate = self
    }
    
    @objc func doneButtonAction()
    {
        self.numberTextField.resignFirstResponder()
    }
    
    func updateWith(patient: Patient, editable: Bool) {
        self.patient = patient
        
        segmentedControl.items = ["Pano", "BWX", "PA's"]
        setsSegmentedControl.items = ["2", "4"]
        typeSegmentedControl.items = panoItems
        updateEditable(editable: editable)
    }
    
    func getData() -> (xray: Bool, requirement: xRayRequirement?, type: xRayType?, sets: Int?, pa: Int?) {
        return (self.xraySwitch.isOn, self.xrayRequirement, self.xrayType, self.sets, self.paNumber)
    }
    
    func updateEditable(editable: Bool) {
        if !editable {
            self.xraySwitch.isUserInteractionEnabled = false
            self.segmentedControl.isUserInteractionEnabled = false
            self.typeSegmentedControl.isUserInteractionEnabled = false
            self.setsSegmentedControl.isUserInteractionEnabled = false
            self.numberTextField.isUserInteractionEnabled = false
            
            self.numberTextField.backgroundColor = UIColor.myLightGray()
            
            self.leftXrayRequirementView.backgroundColor = UIColor.myLightGray()
            self.rightXrayRequirementView.backgroundColor = UIColor.myLightGray()
            self.leftXrayTypeView.backgroundColor = UIColor.myLightGray()
            self.rightXrayTypeView.backgroundColor = UIColor.myLightGray()
            self.leftPaView.backgroundColor = UIColor.myLightGray()
            self.rightPaView.backgroundColor = UIColor.myLightGray()
            self.leftSetsView.backgroundColor = UIColor.myLightGray()
            self.rightSetsView.backgroundColor = UIColor.myLightGray()
            self.paTextFieldBackgroundView.backgroundColor = UIColor.myLightGray()
            self.segmentedControl.newBackgroundColor = UIColor.myLightGray()
            self.typeSegmentedControl.newBackgroundColor = UIColor.myLightGray()
            self.setsSegmentedControl.newBackgroundColor = UIColor.myLightGray()
            self.bottomView.backgroundColor = UIColor.myLightGray()
            self.contentView.backgroundColor = UIColor.myLightGray()
        } else {
            self.xraySwitch.isUserInteractionEnabled = true
            self.segmentedControl.isUserInteractionEnabled = true
            self.typeSegmentedControl.isUserInteractionEnabled = true
            self.setsSegmentedControl.isUserInteractionEnabled = true
            self.numberTextField.isUserInteractionEnabled = true
            
            self.numberTextField.backgroundColor = .white
            
            self.leftXrayRequirementView.backgroundColor = .white
            self.rightXrayRequirementView.backgroundColor = .white
            self.leftXrayTypeView.backgroundColor = .white
            self.rightXrayTypeView.backgroundColor = .white
            self.leftPaView.backgroundColor = .white
            self.rightPaView.backgroundColor = .white
            self.leftSetsView.backgroundColor = .white
            self.rightSetsView.backgroundColor = .white
            self.paTextFieldBackgroundView.backgroundColor = .white
            self.segmentedControl.newBackgroundColor = .white
            self.typeSegmentedControl.newBackgroundColor = .white
            self.setsSegmentedControl.newBackgroundColor = .white
            self.bottomView.backgroundColor = .white
            self.contentView.backgroundColor = .white
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        print(touches.first!.location(in: self))
    }
    
    @IBAction func xraySwitched(_ sender: UISwitch) {
        if sender.isOn {
            self.xrayRequirement = .pano
            self.xrayType = .cbct
            self.xrayOptionsStack.isHidden = false
            self.typeStack.isHidden = false
            pano()
        } else {
            self.xrayOptionsStack.isHidden = true
            self.typeStack.isHidden = true
        }
        
        self.delegate?.xrayUpdated(xray: self.xraySwitch.isOn, requirement: self.xrayRequirement, type: self.xrayType, paNumber: self.paNumber, sets: self.sets)
    }
    
    @IBAction func xrayChanged(_ sender: CustomSegmentedControl) {
        
        switch sender.selectedIndex {
        case 0:
            self.xrayRequirement = .pano
            self.xrayType = .cbct
            pano()
            break
        case 1:
            self.xrayRequirement = .bwx
            self.xrayType = .schick
            bwx()
            break
        case 2:
            self.xrayRequirement = .pa
            self.xrayType = .schick
            pa()
            break
        default:
            break
        }
        
        self.delegate?.xrayUpdated(xray: self.xraySwitch.isOn, requirement: self.xrayRequirement, type: self.xrayType, paNumber: self.paNumber, sets: self.sets)
    }
    
    @IBAction func xrayTypeChanged(_ sender: CustomSegmentedControl) {
        if let xrayRequirement = self.xrayRequirement {
            switch xrayRequirement {
            case .pano:
                self.sets = nil
                self.paNumber = nil
                switch sender.selectedIndex {
                case 0:
                    self.xrayType = .cbct
                    break
                case 1:
                    self.xrayType = .scanX
                    break
                default:
                    break
                }
                break
            case .bwx:
                self.paNumber = nil
                self.sets = 2
                switch sender.selectedIndex {
                case 0:
                    self.xrayType = .schick
                    break
                case 1:
                    self.xrayType = .scanX
                    break
                default:
                    break
                }
                break
            case .pa:
                self.sets = nil
                self.paNumber = self.originalPaNumber ?? 0
                switch sender.selectedIndex {
                case 0:
                    self.xrayType = .schick
                    break
                case 1:
                    self.xrayType = .scanX
                    break
                default:
                    break
                }
                break
            }
            
            self.delegate?.xrayUpdated(xray: self.xraySwitch.isOn, requirement: self.xrayRequirement, type: self.xrayType, paNumber: self.paNumber, sets: self.sets)
        }
    }
    
    @IBAction func setsChanged(_ sender: CustomSegmentedControl) {
        if sender.selectedIndex == 0 {
            self.sets = 2
        } else {
            self.sets = 4
        }
        
        self.delegate?.xrayUpdated(xray: self.xraySwitch.isOn, requirement: self.xrayRequirement, type: self.xrayType, paNumber: self.paNumber, sets: self.sets)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let paNum = Int(textField.text!) {
            print(paNum)
            self.paNumber = paNum
        } else {
            print("Could NOT convert to Integer.")
        }
        
        self.delegate?.xrayUpdated(xray: self.xraySwitch.isOn, requirement: self.xrayRequirement, type: self.xrayType, paNumber: self.paNumber, sets: self.sets)
    }
    
    func pano() {
        self.typeSegmentedControl.items = self.panoItems
        self.typeStackView.isHidden = false
        self.typeSegmentedControl.isHidden = false
        self.setsStack.isHidden = true
        self.setsSegmentedControl.isHidden = true
        self.nPAStack.isHidden = true
        self.nPALabel.isHidden = true
        self.numberTextField.isHidden = true
    }
    
    func bwx() {
        self.typeSegmentedControl.items = self.bwxItems
        self.typeStackView.isHidden = false
        self.typeSegmentedControl.isHidden = false
        self.setsStack.isHidden = false
        self.setsSegmentedControl.isHidden = false
        self.nPAStack.isHidden = true
        self.nPALabel.isHidden = true
        self.numberTextField.isHidden = true
    }
    
    func pa() {
        self.typeSegmentedControl.items = self.paItems
        self.typeStackView.isHidden = false
        self.typeSegmentedControl.isHidden = false
        self.setsSegmentedControl.isHidden = true
        self.setsStack.isHidden = true
        self.nPAStack.isHidden = false
        self.nPALabel.isHidden = false
        self.numberTextField.isHidden = false
    }
}
