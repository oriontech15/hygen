//
//  PatientDetailTableViewController.swift
//  DHS
//
//  Created by Justin Smith on 8/14/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import MessageUI

protocol CheckXrayDataDelegate {
    func getData() -> (xray: Bool, requirement: xRayRequirement?, type: xRayType?, sets: Int?, pa: Int?)
}

protocol CheckClassDataDelegate {
    func getData() -> String
}

protocol CheckAppointmentDataDelegate {
    func getData() -> NSDate?
}

protocol CheckInjectionDataDelegate {
    func getData() -> (injectionOn: Bool, injections: Int?)
}

protocol CheckQuadsDataDelegate {
    func getData() -> Int?
}

protocol CheckNotesDataDelegate {
    func getData() -> String?
}

class PatientDetailTableViewController: UITableViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, AppointmentCellDelegate, XrayCellDelegate, InjectionsCellDelegate, QuadsCellDelegate, NotesCellDelegate, AddXrayButtonDelegate {
    
    var patient: Patient!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneEmailStackView: UIStackView!
    @IBOutlet weak var phoneButton: PhoneButton!
    @IBOutlet weak var emailButton: EmailButton!
    @IBOutlet weak var textButton: TextButton!
    @IBOutlet weak var emailStackView: UIStackView!
    @IBOutlet weak var phoneStackView: UIStackView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var saveEmailButton: UIButton!
    @IBOutlet weak var savePhoneButton: UIButton!
    
    @IBOutlet weak var completeButton: CustomButton!
    
    var xrayDelegate: CheckXrayDataDelegate?
    var appointmentDelegate: CheckAppointmentDataDelegate?
    var notesDelegate: CheckNotesDataDelegate?
    var classDelegate: CheckClassDataDelegate?
    var injectionDelegate: CheckInjectionDataDelegate?
    var quadsDelegate: CheckQuadsDataDelegate?
    
    var firstLoad: Bool = true
    var changesMade: Bool = false
    var saveButtonUsed: Bool = false
    
    var cellHeightDictionary: [IndexPath : CGFloat] = [:]
    
    var xraysOn: Bool = false {
        didSet {
            print("xrays on/off updated")
        }
    }
    
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
    
    var injections: Int? {
        didSet {
            print("Injections - Updated!")
        }
    }
    
    var injectionsOn: Bool? {
        didSet {
            print("Injections On - Updated!")
        }
    }
    
    var quads: Int? {
        didSet {
            print("Quads - Updated!")
        }
    }
    
    var notes: String? {
        didSet {
            print("Notes - Updated!")
        }
    }
    
    var phone: String? {
        didSet {
            print("Notes - Updated!")
        }
    }
    
    var email: String? {
        didSet {
            print("Notes - Updated!")
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
    
    var complete: Bool = false {
        didSet {
            print("Complete - Updated!")
        }
    }
    
    var firstLoadComplete: Bool = true
    
    var editable: Bool = true {
        didSet {
            if self.complete && !firstLoadComplete {
                saveButtonTapped()
            }
            self.tableView.reloadData()
        }
    }
    
    var additionalXrayCount: Int = 0 {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var originalClass: String?
    var originalDate: NSDate?
    var originalInjections: Int?
    var originalInjectionsOn: Bool?
    var originalQuads: Int?
    var originalNotes: String?
    var originalPhone: String?
    var originalEmail: String?
    var originalComplete: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        self.nameLabel.text = patient.firstName + " " + patient.lastName
        self.completeButton.backgroundColor = AppearanceController.shared.mainColor
        
        setupView()
        
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
        
        self.phoneTextField.inputAccessoryView = doneToolbar
        self.emailTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.phoneTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
    }
    
    func setupView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        firstLoad = false
        if self.patient != nil {
            
            self.originalClass = patient.requirement.type
            self.originalDate = patient.dateOfAppointment
            self.originalInjections = Int(patient.injections)
            self.originalQuads = Int(patient.quads)
            self.originalNotes = patient.notes
            self.originalEmail = patient.email
            self.originalPhone = patient.phone
            self.originalComplete = patient.complete
            self.emailAddressLabel.text = patient.email ?? "Add Email"
            self.phoneNumberLabel.text = patient.phone ?? "Add Phone"
            if patient.phone == nil {
                self.phoneButton.hasPhone = false
                self.phoneButton.isEnabled = false
                self.textButton.hasText = false
                self.textButton.isEnabled = false
            } else {
                self.phoneButton.hasPhone = true
                self.phoneButton.isEnabled = true
                self.textButton.hasText = true
                self.textButton.isEnabled = true
            }
            if patient.email == nil {
                self.emailButton.hasEmail = false
                self.emailButton.isEnabled = false
            } else {
                self.emailButton.hasEmail = true
                self.emailButton.isEnabled = true
            }
            
            self.date = originalDate
            self.quads = originalQuads
            self.notes = originalNotes
            self.email = originalEmail
            self.phone = originalPhone
            self.complete = originalComplete!
            
            updateComplete(complete: self.complete)
            firstLoadComplete = false
        }
    }
    
    @objc func back(sender: UIBarButtonItem) {
        if !saveButtonUsed {
            checkForChanges(saveButton: self.saveButtonUsed) {
                if self.changesMade {
                    let alert = UIAlertController(title: "Save Changes", message: "Would you like to save your changes for \(self.patient.firstName) \(self.patient.lastName)", preferredStyle: .alert)
                    let noAction = UIAlertAction(title: "No", style: .cancel, handler: { (action) in
                        
                        _ = self.navigationController?.popViewController(animated: true)
                    })
                    
                    let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                        
                        if let date = self.date {
                            PatientsController.shared.updateDateFor(patient: self.patient, date: date)
                        }
                        
                        if let injections = self.injections {
                            PatientsController.shared.updateInjectionsFor(patient: self.patient, injectionsOn: self.injectionsOn, injections: injections)
                        }
                        
                        if let quads = self.quads {
                            PatientsController.shared.updateQuadsFor(patient: self.patient, quads: quads)
                        }
                        
                        if let notes = self.notes {
                            PatientsController.shared.updateNotesFor(patient: self.patient, notes: notes)
                        }
                        
                        if let email = self.email {
                            PatientsController.shared.updateEmailFor(patient: self.patient, email: email)
                        }
                        
                        if let phone = self.phone {
                            PatientsController.shared.updatePhoneFor(patient: self.patient, phone: phone)
                        }
                        
                        DispatchQueue.main.async {
                            _ = self.navigationController?.popViewController(animated: true)
                        }
                    })
                    alert.addAction(noAction)
                    alert.addAction(yesAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    func checkForChanges(saveButton: Bool, completion: @escaping () -> Void) {
        
        if saveButton {
            
            let group = DispatchGroup()
            let queue = DispatchQueue(label: "getData")
            queue.async {
                group.enter()
                let appointmentData = self.appointmentDelegate?.getData()
                let notesData = self.notesDelegate?.getData()
                self.date = appointmentData
                self.notes = notesData
                group.leave()
            }
            
            group.notify(queue: queue, execute: {
                DispatchQueue.main.async {
                    completion()
                }
            })
        } else {
            
            let group = DispatchGroup()
            let queue = DispatchQueue(label: "getData")
            queue.async {
                group.enter()
                let appointmentData = self.appointmentDelegate?.getData()
                let notesData = self.notesDelegate?.getData()
                if self.originalDate != appointmentData {
                    self.date = appointmentData
                    self.changesMade = true
                }
                if self.originalNotes != notesData {
                    self.notes = notesData
                    self.changesMade = true
                }
                if self.originalEmail != self.email {
                    self.changesMade = true
                }
                if self.originalPhone != self.phone {
                    self.changesMade = true
                }
                group.leave()
            }
            
            group.notify(queue: queue, execute: {
                DispatchQueue.main.async {
                    completion()
                }
            })
        }
    }
    
    /************************/
    /** DELEGATE FUNCTIONS **/
    /************************/
    
    func appointmentUpdated(date: NSDate) {
        self.date = date
    }
    
    func changeButtonTapped() {
        self.tableView.beginUpdates()
        self.tableView.layoutIfNeeded()
        self.tableView.endUpdates()
    }
    
    func xrayUpdated(xray: Bool, requirement: xRayRequirement?, type: xRayType?, paNumber: Int?, sets: Int?) {
        self.xraysOn = xray
        self.xrayRequirement = requirement
        self.xrayType = type
        self.paNumber = paNumber
        self.sets = sets ?? 2
        self.tableView.beginUpdates()
        self.tableView.layoutIfNeeded()
        self.tableView.endUpdates()
    }
    
    func injectionsUpdated(injectionsOn: Bool, injections: Int) {
        self.injectionsOn = injectionsOn
        self.injections = injections
    }
    
    func injectionsOnUpdated() {
        self.tableView.beginUpdates()
        self.tableView.layoutIfNeeded()
        self.tableView.endUpdates()
    }
    
    func quadsUpdated(quads: Int) {
        self.quads = quads
    }
    
    func notesUpdated(notes: String) {
        self.notes = notes
    }
    
    func noteTextCountNeedsUpdating(notes: String) {
        self.notes = notes
        self.tableView.beginUpdates()
        self.tableView.layoutIfNeeded()
        self.tableView.endUpdates()
    }
    
    func addXrayButtonTapped() {
        self.additionalXrayCount += 1
    }
    
    @IBAction func saveButtonTapped() {
        self.tableView.endEditing(true)
        
        self.saveButtonUsed = true
        
        self.checkForChanges(saveButton: self.saveButtonUsed) {
            
            if let date = self.date {
                PatientsController.shared.updateDateFor(patient: self.patient, date: date)
            }
            
            if let injections = self.injections {
                PatientsController.shared.updateInjectionsFor(patient: self.patient, injectionsOn: self.injectionsOn, injections: injections)
            }
            
            if let quads = self.quads {
                PatientsController.shared.updateQuadsFor(patient: self.patient, quads: quads)
            }
            
            if let notes = self.notes {
                PatientsController.shared.updateNotesFor(patient: self.patient, notes: notes)
            }
            
            if let email = self.email {
                PatientsController.shared.updateEmailFor(patient: self.patient, email: email)
            }
            
            if let phone = self.phone {
                PatientsController.shared.updatePhoneFor(patient: self.patient, phone: phone)
            }
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches.first!.location(in: self.tableView))
    }
    
    @IBAction func emailLabelTapped() {
        self.emailAddressLabel.isHidden = true
        self.emailTextField.isHidden = false
        self.saveEmailButton.isHidden = false
    }
    
    @IBAction func saveEmailButtonTapped() {
        self.emailTextField.resignFirstResponder()
        if let text = emailTextField.text {
            if text.contains("@") && text != "" {
                self.emailAddressLabel.text = emailTextField.text
                self.email = emailTextField.text
                self.emailButton.hasEmail = true
                self.emailButton.isEnabled = true
            } else {
                self.email = nil
                self.emailAddressLabel.text = "Add Email"
            }
        }
        
        self.emailAddressLabel.isHidden = false
        self.emailTextField.isHidden = true
        self.saveEmailButton.isHidden = true
    }
    
    @IBAction func phoneLabelTapped() {
        self.phoneNumberLabel.isHidden = true
        self.phoneTextField.isHidden = false
        self.savePhoneButton.isHidden = false
    }
    
    @IBAction func savePhoneButtonTapped() {
        self.phoneTextField.resignFirstResponder()
        if let text = phoneTextField.text {
            if text != "" {
                self.phoneNumberLabel.text = text
                self.phone = text
                self.phoneButton.hasPhone = true
                self.phoneButton.isEnabled = true
                self.textButton.hasText = true
                self.textButton.isEnabled = true
                self.phoneButton.setNeedsDisplay()
                self.textButton.setNeedsDisplay()
            } else {
                self.phone = nil
                self.phoneNumberLabel.text = "Add Phone"
            }
        }
        
        self.phoneNumberLabel.isHidden = false
        self.phoneTextField.isHidden = true
        self.savePhoneButton.isHidden = true
    }
    
    @IBAction func phoneCallButtonTapped() {
        if let phoneNumber = phoneNumberLabel.text {
            call(phone: phoneNumber)
        }
    }
    
    @IBAction func sendSMSMessage(_ sender: AnyObject) {
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = "";
        if let phone = self.phoneNumberLabel.text {
            messageVC.recipients = [phone]
        }
        messageVC.messageComposeDelegate = self;
        
        self.present(messageVC, animated: false, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResult.cancelled.rawValue:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed.rawValue:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        default:
            break;
        }
    }
    
    private func call(phone: String) {
        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func emailButtonTapped() {
        sendEmail()
    }
    
    @IBAction func completeButtonTapped() {
        self.complete = !self.complete
        updateComplete(complete: self.complete)
        PatientsController.shared.completePatient(patient: patient, isComplete: self.complete)
    }
    
    func updateComplete(complete: Bool) {
        if complete {
            self.completeButton.titleLabel?.numberOfLines = 0
            self.completeButton.titleLabel?.textAlignment = .center
            
            //assigning diffrent fonts to both substrings
            let font: UIFont? = UIFont(name: "Comfortaa-Regular", size: 18.0)
            let attrString = NSMutableAttributedString(
                string: "Patient Completed",
                attributes: [NSAttributedStringKey.font : font!])
            
            let font1: UIFont? = UIFont(name: "Comfortaa-Regular", size: 10.0)
            let attrString1 = NSMutableAttributedString(
                string: "\n(tap again to edit patient)",
                attributes: [NSAttributedStringKey.font : font1!])
            
            //appending both attributed strings
            attrString.append(attrString1)
            
            //assigning the resultant attributed strings to the button
            completeButton.setAttributedTitle(attrString, for: .normal)
            self.footerView.backgroundColor = UIColor.myLightGray()
            self.editable = false
        } else {
            self.completeButton.setTitle("Complete Patient", for: .normal)
            self.footerView.backgroundColor = UIColor.white
            self.editable = true
        }
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            if let email = self.emailAddressLabel.text {
                mail.setToRecipients([email])
                mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
                
                present(mail, animated: true)
            } else {
                showSendMailErrorAlert(noEmail: true)
            }
        } else {
            showSendMailErrorAlert(noEmail: false)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func showSendMailErrorAlert(noEmail: Bool) {
        
        if noEmail {
            let alert = UIAlertController(title: "Could not retrieve email", message: "Please try updating the email and try again", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okay)
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okay)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toXrayView" {
            if let vc = segue.destination as? XrayTableViewController {
                vc.patient = self.patient
            }
        } else if segue.identifier == "toInjectionsView" {
            if let vc = segue.destination as? InjectionSetupViewController {
                vc.patient = self.patient
            }
        } else if segue.identifier == "toQuadsView" {
            if let vc = segue.destination as? QuadSetupViewController {
                vc.patient = self.patient
            }
        }
    }
    
    /************************************/
    /** TABLEVIEW DATASOURCE FUNCTIONS **/
    /************************************/
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentCell", for: indexPath) as? UpdateAppointmentTableViewCell
            cell?.updateWith(patient: self.patient, editable: self.editable)
            cell?.delegate = self
            self.appointmentDelegate = cell
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "toXrayViewCell", for: indexPath)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "toInjectionsViewCell", for: indexPath)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath) as? UpdateClassTableViewCell
            cell?.updateWith(patient: self.patient, editable: self.editable)
            self.classDelegate = cell
            return cell ?? UITableViewCell()
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "toQuadsViewCell", for: indexPath)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as? NotesTableViewCell
            cell?.updateWith(patient: self.patient, editable: self.editable)
            cell?.delegate = self
            self.notesDelegate = cell
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            self.performSegue(withIdentifier: "toXrayView", sender: nil)
        } else if indexPath.row == 2 {
            self.performSegue(withIdentifier: "toInjectionsView", sender: nil)
        } else if indexPath.row == 4 {
            self.performSegue(withIdentifier: "toQuadsView", sender: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeightDictionary[indexPath] = cell.frame.size.height
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 119
        } else {
            return UITableViewAutomaticDimension
        }
    }
}
