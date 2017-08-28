//
//  AppointmentTableViewCell.swift
//  DHS
//
//  Created by Justin Smith on 6/13/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var classTag: ClassTagView!
    
    @IBOutlet weak var topSeparator: UIView!
    @IBOutlet weak var bottomSeparator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateWith(patient: Patient, cellLocation: CellLocation) {
        
        switch cellLocation {
        case .off:
            break
        case .first:
            bottomSeparator.isHidden = false
            break
        case .last:
            break
        case .neither:
            bottomSeparator.isHidden = false
            break
        }
        
        if patient.complete {
            self.seperatorView.backgroundColor = UIColor.myGray()
            self.contentView.backgroundColor = UIColor.myLightGray()
            self.classTag.complete = true
            switch patient.requirement.type {
            case RequirementType.class1A.rawValue:
                self.classTag.requirementType = .class1A
                break
            case RequirementType.class1B.rawValue:
                self.classTag.requirementType = .class1B
                break
            case RequirementType.class2.rawValue:
                self.classTag.requirementType = .class2
                break
            case RequirementType.class3.rawValue:
                self.classTag.requirementType = .class3
                break
            case RequirementType.class4.rawValue:
                self.classTag.requirementType = .class4
                break
            case RequirementType.class5.rawValue:
                self.classTag.requirementType = .class5
                break
            default:
                break
            }
        } else {
            self.classTag.complete = false
            switch patient.requirement.type {
            case RequirementType.class1A.rawValue:
                //self.classLabel.text = "1A"
                self.seperatorView.backgroundColor = UIColor.myPurple()
                self.contentView.backgroundColor = UIColor.lightPurple()
                self.classTag.requirementType = .class1A
                break
            case RequirementType.class1B.rawValue:
                //self.classLabel.text = "1B"
                self.seperatorView.backgroundColor = UIColor.myOrange()
                self.contentView.backgroundColor = UIColor.lightOrange()
                self.classTag.requirementType = .class1B
                break
            case RequirementType.class2.rawValue:
                //self.classLabel.text = "2"
                self.seperatorView.backgroundColor = UIColor.myGreen()
                self.contentView.backgroundColor = UIColor.lightGreen()
                self.classTag.requirementType = .class2
                break
            case RequirementType.class3.rawValue:
                //self.classLabel.text = "3"
                self.seperatorView.backgroundColor = UIColor.myBlue()
                self.contentView.backgroundColor = UIColor.lightBlue()
                self.classTag.requirementType = .class3
                break
            case RequirementType.class4.rawValue:
                //self.classLabel.text = "4"
                self.seperatorView.backgroundColor = UIColor.myRed()
                self.contentView.backgroundColor = UIColor.lightRed()
                self.classTag.requirementType = .class4
                break
            case RequirementType.class5.rawValue:
                //self.classLabel.text = "5"
                self.seperatorView.backgroundColor = UIColor.myYellow()
                self.contentView.backgroundColor = UIColor.lightYellow()
                self.classTag.requirementType = .class5
                break
            default:
                break
            }
        }
        
        self.patientNameLabel.text = patient.firstName + " " + patient.lastName
        self.timeLabel.text = patient.dateOfAppointment.time()
    }
    
}
