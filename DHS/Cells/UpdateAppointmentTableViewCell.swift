//
//  UpdateAppointmentTableViewCell.swift
//  DHS
//
//  Created by Justin Smith on 8/14/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

protocol AppointmentCellDelegate {
    func appointmentUpdated(date: NSDate)
    func changeButtonTapped()
}

class UpdateAppointmentTableViewCell: UITableViewCell, CheckAppointmentDataDelegate {

    @IBOutlet weak var changeDateButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var originalDate: NSDate?
    
    var date: NSDate? {
        didSet {
            print("Date - Updated!")
        }
    }
    
    var patient: Patient!
    
    var delegate: AppointmentCellDelegate?
    
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
        setupView()
    }
    
    func getData() -> NSDate? {
        return self.date
    }
    
    func updateEditable(editable: Bool) {
        if !editable {
            self.changeDateButton.isHidden = true
            self.contentView.backgroundColor = UIColor.myLightGray()
        } else {
            self.changeDateButton.isHidden = false
            self.contentView.backgroundColor = UIColor.white
        }
    }
    
    func setupView() {
        firstLoad = false
        if self.patient != nil {
            self.originalDate = patient.dateOfAppointment
            let date = patient.dateOfAppointment as NSDate
            self.date = date
            let dateString = date.toString()
            let time = date.time()
            self.dateLabel.text = dateString
            self.timeLabel.text = time
            self.datePicker.date = patient.dateOfAppointment as Date
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func changeButtonTapped() {
        if datePicker.isHidden == true {
            self.datePicker.isHidden = false
            self.changeDateButton.setTitle("Save", for: .normal)
        } else {
            self.datePicker.isHidden = true
            self.changeDateButton.setTitle("Change", for: .normal)
        }
        
        self.delegate?.changeButtonTapped()
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let date = sender.date as NSDate
        let dateString = date.toString()
        let time = date.time()
        self.dateLabel.text = dateString
        self.timeLabel.text = time
        self.date = sender.date as NSDate
        if let date = self.date {
            self.delegate?.appointmentUpdated(date: date)
        }
    }
}
