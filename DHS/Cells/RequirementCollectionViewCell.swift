//
//  RequirementCollectionViewCell.swift
//  DHS
//
//  Created by Justin Smith on 6/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class RequirementCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var requirementBackground: RequirementBGView!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var requirementTotalButton: RequirementTotalButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateWith(requirementType: RequirementType, requirement: Requirement, textColor: UIColor) {
        self.requirementTotalButton.setTitleColor(textColor, for: .normal)
        self.classLabel.textColor = textColor
        print("\(requirement.type) -- \(requirement.total)")
        self.classLabel.text = requirementType.rawValue
        
        switch requirementType {
        case .class1A:
            requirementTotalButton.classRequirement = RequirementController.shared.class1A
            break
        case .class1B:
            requirementTotalButton.classRequirement = RequirementController.shared.class1B
            break
        case .class2:
            requirementTotalButton.classRequirement = RequirementController.shared.class2
            break
        case .class3:
            self.classLabel.text = "Class 3/4"
            requirementTotalButton.classRequirement = RequirementController.shared.class3
            break
        case .class4:
            self.classLabel.text = "Class 3/4"
            requirementTotalButton.classRequirement = RequirementController.shared.class4
            break
        case .class5:
            requirementTotalButton.classRequirement = RequirementController.shared.class5
            break
        case .pano:
            requirementTotalButton.classRequirement = RequirementController.shared.pano
        case .bwx:
            requirementTotalButton.classRequirement = RequirementController.shared.bwx
        case .pa:
            requirementTotalButton.classRequirement = RequirementController.shared.pa
        case .injection:
            requirementTotalButton.classRequirement = RequirementController.shared.injections
        default:
            break
        }
        
        self.requirementTotalButton.setTitle("\(requirement.total)", for: .normal)
        self.requirementBackground.requirementType = requirementType
    }
}
