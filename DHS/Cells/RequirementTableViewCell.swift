//
//  RequirementTableViewCell.swift
//  DHS
//
//  Created by Justin Smith on 6/13/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class RequirementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressNumbersLabel: UILabel!
    @IBOutlet weak var progressView: CircleProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.progressView.trackColor = .clear
        self.progressView.glowAmount = 0
        self.progressView.glowMode = CircularProgressGlowMode.noGlow
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateWith(requirement: Requirement) {
        self.className.text = requirement.type
        
        var progress: Double = 0
        
        switch requirement.type {
        case RequirementType.class1A.rawValue:
            self.progressView.progressColors = UIColor.purpleGradientColors()
            self.className.textColor = UIColor.myPurple()
            progress = ProgressController.shared.class1AProgress
            updateNumbersLabel(requirement: "Class 1A")
        case RequirementType.class1B.rawValue:
            self.progressView.progressColors = UIColor.orangeGradientColors()
            self.className.textColor = UIColor.myOrange()
            progress = ProgressController.shared.class1BProgress
            updateNumbersLabel(requirement: "Class 1B")
        case RequirementType.class2.rawValue:
            self.progressView.progressColors = UIColor.greenGradientColors()
            self.className.textColor = UIColor.myGreen()
            progress = ProgressController.shared.class2Progress
            updateNumbersLabel(requirement: "Class 2")
        case RequirementType.class3.rawValue:
            self.progressView.progressColors = UIColor.blueGradientColors()
            self.className.textColor = UIColor.myBlue()
            progress = ProgressController.shared.class3_4Progress
            updateNumbersLabel(requirement: "Class 3")
        case RequirementType.class4.rawValue:
            self.progressView.progressColors = UIColor.redGradientColors()
            self.className.textColor = UIColor.myRed()
            progress = ProgressController.shared.class3_4Progress
            updateNumbersLabel(requirement: "Class 4")
        case RequirementType.class5.rawValue:
            self.progressView.progressColors = UIColor.yellowGradientColors()
            self.className.textColor = UIColor.myYellow()
            progress = ProgressController.shared.class5Progress
            updateNumbersLabel(requirement: "Class 5")
        default:
            break
        }
        
        updateProgressOnView(label: self.progressLabel, view: self.progressView, progress: progress)
    }
    
    func updateNumbersLabel(requirement: String) {
        switch requirement {
        case RequirementType.class1A.rawValue:
            let current = ProgressController.shared.totalCurrentClass1A
            let total = ProgressController.shared.totalClass1A
            self.progressNumbersLabel.text = "\(current) / \(total)"
            break
        case RequirementType.class1B.rawValue:
            let current = ProgressController.shared.totalCurrentClass1B
            let total = ProgressController.shared.totalClass1B
            self.progressNumbersLabel.text = "\(current) / \(total)"
            break
        case RequirementType.class2.rawValue:
            let current = ProgressController.shared.totalCurrentClass2
            let total = ProgressController.shared.totalClass2
            self.progressNumbersLabel.text = "\(current) / \(total)"
            break
        case RequirementType.class3.rawValue:
            let current = ProgressController.shared.totalCurrentClass3_4
            let total = ProgressController.shared.totalClass3_4
            self.progressNumbersLabel.text = "\(current) / \(total)"
            break
        case RequirementType.class4.rawValue:
            let current = ProgressController.shared.totalCurrentClass3_4
            let total = ProgressController.shared.totalClass3_4
            self.progressNumbersLabel.text = "\(current) / \(total)"
            break
        case RequirementType.class5.rawValue:
            let current = ProgressController.shared.totalCurrentClass5
            let total = ProgressController.shared.totalClass5
            self.progressNumbersLabel.text = "\(current) / \(total)"
            break
        default:
            break
        }
    }
    
    func updateProgressOnView(label: UILabel?, view: CircleProgressView, progress: Double) {
        print("\(progress)")
        let angle = ProgressController.shared.convertProgressToDegrees(progress: progress)
        let percent = ProgressController.shared.convertProgressToPercent(degrees: angle)
        if let label = label {
            label.text = "\(percent)%"
        }
        view.animate(toAngle: angle, duration: 1.0, completion: nil)
    }
}
