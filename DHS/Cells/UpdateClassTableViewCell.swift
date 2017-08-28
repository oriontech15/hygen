//
//  UpdateClassTableViewCell.swift
//  DHS
//
//  Created by Justin Smith on 8/14/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class UpdateClassTableViewCell: UITableViewCell, CheckClassDataDelegate {
    
    var className: ClassSelectButton!
    var originalClass: String?
        
    @IBOutlet var classButtons: [ClassSelectButton]!
    @IBOutlet weak var classStack: UIStackView!
    
    var selectedIndex: Int = 0
    var patient: Patient!
    
    var firstLoad: Bool = true
    var changesMade: Bool = false
    var saveButtonUsed: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateWith(patient: Patient, editable: Bool) {
        self.patient = patient
        updateEditable(editable: editable)
        setSelectedClass()
    }
    
    func getData() -> String {
        return self.className.currentSelected.rawValue
    }
    
    func updateEditable(editable: Bool) {
        if !editable {
            self.classStack.isUserInteractionEnabled = false
            self.contentView.backgroundColor = UIColor.myLightGray()
        } else {
            self.classStack.isUserInteractionEnabled = true
            self.contentView.backgroundColor = UIColor.white
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
}
