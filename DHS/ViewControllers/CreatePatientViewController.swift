//
//  CreatePatientViewController.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

protocol PatientCreatedDelegate {
    func patientCreated()
}

class CreatePatientViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var createButton: CustomButton!
    
    @IBOutlet var classButtons: [ClassSelectButton]!
    
    var date: Date?
    
    var selectedIndex: Int = 0
    var didSelectClass: Bool = false
    var delegate: PatientCreatedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        if let date = self.date {
            self.datePicker.date = date
            let newDate = date as NSDate
            self.dateLabel.text = newDate.toString() + " @ " + newDate.time()
        }
        
        createButton.backgroundColor = AppearanceController.shared.mainColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func classButtonSelected(sender: UIButton) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        classButtons[previousIndex].notSelected()
        classButtons[selectedIndex].selected()
        didSelectClass = true
    }
    
    @IBAction func createButtonTapped(sender: UIButton) {
        var requirement: Requirement?

        if didSelectClass {
            let type = classButtons[selectedIndex].currentSelected
            switch type {
            case .class1A:
                requirement = RequirementController.shared.class1A
                break
            case .class1B:
                requirement = RequirementController.shared.class1B
                break
            case .class2:
                requirement = RequirementController.shared.class2
                break
            case .class3:
                requirement = RequirementController.shared.class3
                break
            case .class4:
                requirement = RequirementController.shared.class4
                break
            case .class5:
                requirement = RequirementController.shared.class5
                break
            default:
                break
            }
        } else {
            presentAlert(message: "Please select a class. You can change this later if needed.")
            return
        }
        
        var fName = ""
        var lName = ""
        var classRequirement: Requirement!
        
        let date = datePicker.date
        if firstNameTextField.text != "" {
            guard let firstName = firstNameTextField.text else {
                presentAlert(message: "First name required")
                return
            }
            fName = firstName
        } else {
            presentAlert(message: "First name required")
        }
        
        if lastNameTextField.text != "" {
            guard let lastName = lastNameTextField.text else {
                presentAlert(message: "Last name required")
                return
            }
            lName = lastName
        } else {
            presentAlert(message: "Last name required")
        }
        
        if didSelectClass {
            guard let require = requirement else {
                presentAlert(message: "Please select a class. You can change this later if needed.")
                return
            }
            classRequirement = require
        } else {
            presentAlert(message: "Please select a class. You can change this later if needed.")
        }
        
        if dateLabel.text != "" {
            _ = PatientsController.shared.createPatient(firstName: fName, lastName: lName, date: date, requirement: classRequirement)
            
            clearEverything()
        } else {
            presentAlert(message: "Please supply a date for an appointment with the patient. You can change this later if needed.")
        }
    }
    
    func presentAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func datePickerUpdated(sender: UIDatePicker) {
        let date = sender.date as NSDate
        let time = date.time()
        self.dateLabel.text = date.toString() + " @ " + time
    }
    
    func clearEverything() {
        for button in self.classButtons {
            button.notSelected()
        }
        
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        
        dateLabel.text = ""
        datePicker.date = Date()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
