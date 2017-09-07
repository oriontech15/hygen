//
//  CreateXrayViewController.swift
//  DHS
//
//  Created by Justin Smith on 8/30/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

protocol XrayCellDelegate {
    func xrayUpdated(xray: Bool, requirement: xRayRequirement?, type: xRayType?, paNumber: Int?, sets: Int?)
}

class CreateXrayViewController: UIViewController, UITextFieldDelegate {
    
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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createButton: CustomButton!
    
    var originalXrayType: Int?
    var originalXray: Int?
    var originalSets: Int?
    var originalPaNumber: Int?
    
    var selectedIndex: Int = 0
    
    let panoItems = ["CBCT", "Scan-x"]
    let bwxItems = ["Schick", "Scan-x"]
    let paItems = ["Schick", "Scan-x"]
    
    var pano: Bool = false
    var bwx: Bool = false
    var pa: Bool = false
    var xrayRequirement: xRayRequirement? {
        didSet {
            switch xrayRequirement! {
            case .pano:
                self.pano = true
                self.bwx = false
                self.pa = false
                break
            case .bwx:
                self.pano = false
                self.bwx = true
                self.pa = false
                break
            case .pa:
                self.pano = false
                self.bwx = false
                self.pa = true
                break
            }
        }
    }
    
    var cbct: Bool = false
    var schick: Bool = false
    var scanx: Bool = false
    var xrayType: xRayType? {
        didSet {
            switch xrayType! {
            case .cbct:
                self.cbct = true
                self.schick = false
                self.scanx = false
                break
            case .schick:
                self.cbct = false
                self.schick = true
                self.scanx = false
                break
            case .scanX:
                self.cbct = false
                self.schick = false
                self.scanx = true
                break
            }
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
    
    var xray: Xray!
    var patient: Patient!
    
    var delegate: XrayCellDelegate?
    
    var firstLoad: Bool = true
    var changesMade: Bool = false
    var saveButtonUsed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDoneButtonOnKeyboard()
        xraySwitched()
        
        segmentedControl.items = ["Pano", "BWX", "PA's"]
        setsSegmentedControl.items = ["2", "4"]
        typeSegmentedControl.items = panoItems
        setupView()
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
    
    func setupView() {
        if firstLoad {
            firstLoad = false
            if xray != nil {
                self.titleLabel.text = "Edit Xray"
                self.createButton.setTitle("Save", for: .normal)
                if xray.pano {
                    self.xrayRequirement = .pano
                    self.segmentedControl.selectedIndex = 0
                    if xray.cbct {
                        self.typeSegmentedControl.selectedIndex = 0
                        self.xrayType = .cbct
                        self.originalXrayType = xRayType.cbct.rawValue
                    } else {
                        self.typeSegmentedControl.selectedIndex = 1
                        self.xrayType = .scanX
                        self.originalXrayType = xRayType.scanX.rawValue
                    }
                    self.originalXray = xRayRequirement.pano.rawValue
                    self.panoSelected()
                } else if xray.bwx {
                    self.xrayRequirement = .bwx
                    self.segmentedControl.selectedIndex = 1
                    if xray.schick {
                        self.typeSegmentedControl.selectedIndex = 0
                        self.xrayType = .schick
                        self.originalXrayType = xRayType.schick.rawValue
                    } else {
                        self.typeSegmentedControl.selectedIndex = 1
                        self.xrayType = .scanX
                        self.originalXrayType = xRayType.scanX.rawValue
                    }
                    self.originalXray = xRayRequirement.bwx.rawValue
                    self.originalSets = Int(xray.sets)
                    self.sets = Int(xray.sets)
                    switch sets! {
                    case 2:
                        self.setsSegmentedControl.selectedIndex = 0
                        break
                    case 4:
                        self.setsSegmentedControl.selectedIndex = 1
                        break
                    default:
                        break
                    }
                    self.bwxSelected()
                } else if xray.pa {
                    self.xrayRequirement = .pa
                    self.paNumber = Int(xray.paNumber)
                    self.originalPaNumber = Int(xray.paNumber)
                    self.segmentedControl.selectedIndex = 2
                    if xray.schick {
                        self.typeSegmentedControl.selectedIndex = 0
                        self.xrayType = .schick
                        self.originalXrayType = xRayType.schick.rawValue
                    } else {
                        self.typeSegmentedControl.selectedIndex = 1
                        self.xrayType = .scanX
                        self.originalXrayType = xRayType.scanX.rawValue
                    }
                    self.originalXray = xRayRequirement.pa.rawValue
                    self.numberTextField.text = "\(xray.paNumber)"
                    self.paSelected()
                }
            }
        }
    }
    
    func xraySwitched() {
            self.xrayRequirement = .pano
            
            self.xrayType = .cbct
            self.typeStack.isHidden = false
            panoSelected()
    }
    
    @IBAction func xrayChanged(_ sender: CustomSegmentedControl) {
        
        switch sender.selectedIndex {
        case 0:
            self.xrayRequirement = .pano
            self.xrayType = .cbct
            panoSelected()
            break
        case 1:
            self.xrayRequirement = .bwx
            self.xrayType = .schick
            bwxSelected()
            break
        case 2:
            self.xrayRequirement = .pa
            self.xrayType = .schick
            paSelected()
            break
        default:
            break
        }
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
        }
    }
    
    @IBAction func setsChanged(_ sender: CustomSegmentedControl) {
        if sender.selectedIndex == 0 {
            self.sets = 2
        } else {
            self.sets = 4
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let paNum = Int(textField.text!) {
            print(paNum)
            self.paNumber = paNum
        } else {
            print("Could NOT convert to Integer.")
        }
    }
    
    func panoSelected() {
        self.typeSegmentedControl.items = self.panoItems
        self.typeStackView.isHidden = false
        self.typeSegmentedControl.isHidden = false
        self.setsStack.isHidden = true
        self.setsSegmentedControl.isHidden = true
        self.nPAStack.isHidden = true
        self.nPALabel.isHidden = true
        self.numberTextField.isHidden = true
    }
    
    func bwxSelected() {
        self.typeSegmentedControl.items = self.bwxItems
        self.typeStackView.isHidden = false
        self.typeSegmentedControl.isHidden = false
        self.setsStack.isHidden = false
        self.setsSegmentedControl.isHidden = false
        self.nPAStack.isHidden = true
        self.nPALabel.isHidden = true
        self.numberTextField.isHidden = true
    }
    
    func paSelected() {
        self.typeSegmentedControl.items = self.paItems
        self.typeStackView.isHidden = false
        self.typeSegmentedControl.isHidden = false
        self.setsSegmentedControl.isHidden = true
        self.setsStack.isHidden = true
        self.nPAStack.isHidden = false
        self.nPALabel.isHidden = false
        self.numberTextField.isHidden = false
    }
    
    //Mark: Cancel and Done buttons
    
    @IBAction func cancelButtonTapped() {
        presentAlert(title: "Cancel?", message: "Are you sure you want to cancel creating an Xray", cancelBlock: { (alert) in
            self.dismiss(animated: true, completion: nil)
        }, doneBlock: nil, cancel: true)
    }
    
    func presentAlert(title: String, message: String, cancelBlock: ((UIAlertAction) -> Void)?, doneBlock: ((UIAlertAction) -> Void)?, cancel: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let no = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let yes = UIAlertAction(title: "Yes", style: .default, handler: cancel ? cancelBlock : doneBlock)
        alert.addAction(no)
        alert.addAction(yes)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped() {
        if xray != nil {
            presentAlert(title: "Save?", message: "Update Xray with the current settings?", cancelBlock: nil, doneBlock: { (alert) in
                XrayController.shared.updateXray(xray: self.xray, pano: self.pano, bwx: self.bwx, pa: self.pa, cbct: self.cbct, schick: self.schick, scanx: self.scanx, paNumber: self.paNumber, sets: self.sets)
                self.dismiss(animated: true, completion: nil)
            }, cancel: false)
        } else {
            presentAlert(title: "Create?", message: "Create an Xray with the current settings?", cancelBlock: nil, doneBlock: { (alert) in
                if let xray = XrayController.shared.createXray(patient: self.patient, pano: self.pano, bwx: self.bwx, pa: self.pa, cbct: self.cbct, schick: self.schick, scanx: self.scanx, paNumber: self.paNumber, sets: self.sets) {
                    PatientsController.shared.updatePatientXRays(patient: self.patient, xray: xray)
                    self.dismiss(animated: true, completion: nil)
                }
            }, cancel: false)
        }
    }
}

