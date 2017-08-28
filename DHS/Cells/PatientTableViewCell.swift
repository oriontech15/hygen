//
//  PatientTableViewCell.swift
//  DHS
//
//  Created by Justin Smith on 6/13/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class PatientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateWith(patient: Patient, color: UIColor) {
        self.nameLabel.text = patient.firstName + " " + patient.lastName
        self.nameLabel.textColor = color
        
        if patient.complete {
            self.dateLabel.text = "Complete"
            self.dateLabel.textColor = UIColor.myGreen()
        } else {
            self.dateLabel.text = patient.dateOfAppointment.toString()
        }
    }
}
