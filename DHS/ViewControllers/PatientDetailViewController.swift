//
//  PatientDetailViewController.swift
//  DHS
//
//  Created by Justin Smith on 7/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class PatientDetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!
    @IBOutlet weak var typeSegmentedControl: CustomSegmentedControl!
    @IBOutlet weak var setsSegmentedControl: CustomSegmentedControl!
    
    @IBOutlet weak var setsStack: UIStackView!
    @IBOutlet weak var nPAStack: UIStackView!
    @IBOutlet weak var typeStackView: UIStackView!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nPALabel: UILabel!
    @IBOutlet weak var sepView: UIView!
    
    @IBOutlet weak var xrayOptionsStack: UIStackView!
    @IBOutlet weak var typeStack: UIStackView!
    
    @IBOutlet weak var changeDateButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var xraySwitch: UISwitch!
    
    @IBOutlet var classButtons: [ClassSelectButton]!
    
    var patient: Patient!
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
    var date: NSDate? {
        didSet {
            print("Date - Updated!")
        }
    }
    var className: ClassSelectButton!
    
    var selectedIndex: Int = 0
    
    let panoItems = ["CBCT", "Scan-x"]
    let bwxItems = ["Schick", "Scan-x"]
    let paItems = ["Schick", "Scan-x"]
    
    var firstLoad: Bool = true
    var changesMade: Bool = false
    var saveButtonUsed: Bool = false
    
    var originalClass: String?
    var originalDate: NSDate?
    var originalXrayType: Int?
    var originalXray: Int?
    var originalSets: Int?
    var originalPaNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PatientDetailViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        segmentedControl.items = ["Pano", "BWX", "PA's"]
        setsSegmentedControl.items = ["2", "4"]
        typeSegmentedControl.items = panoItems
        setSelectedClass()
        self.nameLabel.text = patient.firstName + " " + patient.lastName
    }
    
    override func viewWillLayoutSubviews() {
        if firstLoad {
            setupView()
        }
    }
    
    func setupView() {
        firstLoad = false
        if self.patient != nil {
            self.originalClass = patient.requirement.type
            self.originalDate = patient.dateOfAppointment
            if patient.xrays {
                self.xraySwitch.isOn = true
                self.xraySwitched(self.xraySwitch)
                if patient.panoXRay {
                    self.xrayRequirement = .pano
                    self.segmentedControl.selectedIndex = 0
                    if patient.cbct {
                        self.typeSegmentedControl.selectedIndex = 0
                        self.xrayType = .cbct
                        self.originalXrayType = xRayType.cbct.rawValue
                    } else {
                        self.typeSegmentedControl.selectedIndex = 1
                        self.xrayType = .scanX
                        self.originalXrayType = xRayType.scanX.rawValue
                    }
                    self.originalXray = xRayRequirement.pano.rawValue
                    self.pano()
                } else if patient.bwx {
                    self.xrayRequirement = .bwx
                    self.segmentedControl.selectedIndex = 1
                    if patient.schick {
                        self.typeSegmentedControl.selectedIndex = 0
                        self.xrayType = .schick
                        self.originalXrayType = xRayType.schick.rawValue
                    } else {
                        self.typeSegmentedControl.selectedIndex = 1
                        self.xrayType = .scanX
                        self.originalXrayType = xRayType.scanX.rawValue
                    }
                    self.originalXray = xRayRequirement.bwx.rawValue
                    self.originalSets = Int(patient.bwxSets)
                    self.sets = Int(patient.bwxSets)
                    self.bwx()
                } else if patient.pa {
                    self.xrayRequirement = .pa
                    self.paNumber = Int(patient.paNumber)
                    self.originalPaNumber = Int(patient.paNumber)
                    self.segmentedControl.selectedIndex = 2
                    if patient.schick {
                        self.typeSegmentedControl.selectedIndex = 0
                        self.xrayType = .schick
                        self.originalXrayType = xRayType.schick.rawValue
                    } else {
                        self.typeSegmentedControl.selectedIndex = 1
                        self.xrayType = .scanX
                        self.originalXrayType = xRayType.scanX.rawValue
                    }
                    self.originalXray = xRayRequirement.pa.rawValue
                    self.numberTextField.text = "\(patient.paNumber)"
                    self.pa()
                }
            }
            let date = patient.dateOfAppointment as NSDate
            self.date = date
            let dateString = date.toString()
            let time = date.time()
            self.dateLabel.text = dateString
            self.timeLabel.text = time
            self.datePicker.date = patient.dateOfAppointment as Date
        }
    }
    
    func back(sender: UIBarButtonItem) {
        if !saveButtonUsed {
            checkForChanges {
                if changesMade {
                    let alert = UIAlertController(title: "Save Changes", message: "Would you like to save your changes for \(patient.firstName) \(patient.lastName)", preferredStyle: .alert)
                    let noAction = UIAlertAction(title: "No", style: .cancel, handler: { (action) in
                    
                        _ = self.navigationController?.popViewController(animated: true)
                    })
                    
                    let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                        
                        PatientsController.shared.updatePatientXRays(patient: self.patient, xray: self.xraySwitch.isOn, requirement: self.xrayRequirement, type: self.xrayType, paNumber: self.paNumber, sets: self.sets)
                        if let date = self.date {
                            PatientsController.shared.updateDateFor(patient: self.patient, date: date)
                        }
                        
                        DispatchQueue.main.async {
                            _ = self.navigationController?.popViewController(animated: true)
                        }
                    })
                    alert.addAction(noAction)
                    alert.addAction(yesAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    _ = navigationController?.popViewController(animated: true)
                }
            }
        } else {
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    func checkForChanges(completion: () -> Void) {
        
        if originalXray != xrayRequirement?.rawValue {
            self.changesMade = true
        }
        if originalXrayType != xrayType?.rawValue {
            self.changesMade = true
        }
        if originalDate != date {
            self.changesMade = true
        }
        if originalSets != sets {
            self.changesMade = true
        }
        if originalPaNumber != paNumber {
            self.changesMade = true
        }
        
        completion()
    }
    
    @IBAction func classButtonSelected(sender: UIButton) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        classButtons[previousIndex].notSelected()
        classButtons[selectedIndex].selected()
        self.className = classButtons[selectedIndex]
        switch selectedIndex {
        case 0:
            self.className.currentSelected = .class1A
            PatientsController.shared.updatePatientClassRequirement(patient: self.patient, requirement: RequirementController.shared.class1A)
            break
        case 1:
            self.className.currentSelected = .class1B
            PatientsController.shared.updatePatientClassRequirement(patient: self.patient, requirement: RequirementController.shared.class1B)
            break
        case 2:
            self.className.currentSelected = .class2
            PatientsController.shared.updatePatientClassRequirement(patient: self.patient, requirement: RequirementController.shared.class2)
            break
        case 3:
            self.className.currentSelected = .class3
            PatientsController.shared.updatePatientClassRequirement(patient: self.patient, requirement: RequirementController.shared.class3)
            break
        case 4:
            self.className.currentSelected = .class4
            PatientsController.shared.updatePatientClassRequirement(patient: self.patient, requirement: RequirementController.shared.class4)
            break
        case 5:
            self.className.currentSelected = .class5
            PatientsController.shared.updatePatientClassRequirement(patient: self.patient, requirement: RequirementController.shared.class5)
            break
        default:
            break
        }
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
    }
    
    func setSelectedClass() {
        let previousIndex = selectedIndex
        switch RequirementType(rawValue: patient.requirement.type)! {
        case .class1A:
            selectedIndex = 0
            
            classButtons[previousIndex].notSelected()
            classButtons[selectedIndex].selected()
            self.className = classButtons[selectedIndex]
            self.className.currentSelected = .class1A
            break
        case .class1B:
            selectedIndex = 1
            
            classButtons[previousIndex].notSelected()
            classButtons[selectedIndex].selected()
            self.className = classButtons[selectedIndex]
            self.className.currentSelected = .class1B
            break
        case .class2:
            selectedIndex = 2
            
            classButtons[previousIndex].notSelected()
            classButtons[selectedIndex].selected()
            self.className = classButtons[selectedIndex]
            self.className.currentSelected = .class2
            break
        case .class3:
            selectedIndex = 3
            
            classButtons[previousIndex].notSelected()
            classButtons[selectedIndex].selected()
            self.className = classButtons[selectedIndex]
            self.className.currentSelected = .class3
            break
        case .class4:
            selectedIndex = 4
            
            classButtons[previousIndex].notSelected()
            classButtons[selectedIndex].selected()
            self.className = classButtons[selectedIndex]
            self.className.currentSelected = .class4
            break
        case .class5:
            selectedIndex = 5
            
            classButtons[previousIndex].notSelected()
            classButtons[selectedIndex].selected()
            self.className = classButtons[selectedIndex]
            self.className.currentSelected = .class5
            break
        default:
            break
        }
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
        if let paNum = Int(textField.text ?? "") {
            print(paNum)
            self.paNumber = paNum
        } else {
            print("Could NOT convert to Integer.")
        }
    }
    
    @IBAction func screenTapped() {
        self.view.endEditing(true)
    }
    
    @IBAction func doneButtonTapped() {
        PatientsController.shared.updatePatientXRays(patient: self.patient, xray: xraySwitch.isOn, requirement: xrayRequirement, type: xrayType, paNumber: paNumber, sets: sets)
        if let date = date {
            PatientsController.shared.updateDateFor(patient: self.patient, date: date)
        }
        
        self.saveButtonUsed = false
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped() {
        PatientsController.shared.updatePatientXRays(patient: self.patient, xray: xraySwitch.isOn, requirement: xrayRequirement, type: xrayType, paNumber: paNumber, sets: sets)
        if let date = date {
            PatientsController.shared.updateDateFor(patient: self.patient, date: date)
        }
        
        self.saveButtonUsed = true
        
        _ = navigationController?.popViewController(animated: true)
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
    
    @IBAction func changeButtonTapped() {
        if datePicker.isHidden == true {
            self.datePicker.isHidden = false
            self.changeDateButton.setTitle("Save", for: .normal)
        } else {
            self.datePicker.isHidden = true
            self.changeDateButton.setTitle("Change", for: .normal)
        }
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let date = sender.date as NSDate
        let dateString = date.toString()
        let time = date.time()
        self.dateLabel.text = dateString
        self.timeLabel.text = time
        self.date = sender.date as NSDate
    }
}
