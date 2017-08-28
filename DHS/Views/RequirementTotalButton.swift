//
//  RequirementTotalButton.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

protocol RequirementButtonDelegate {
    func requirementButtonTapped(requirement: Requirement, button: RequirementTotalButton)
}

class RequirementTotalButton: UIButton {
    
    var classRequirement: Requirement! {
        didSet {
            setupText()
        }
    }
    
    var delegate: RequirementButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    func setupButton() {
        self.addTarget(self, action: #selector(sendTapNotification), for: .touchUpInside)
    }
    
    func setupText() {
        self.setTitle("\(classRequirement.total)", for: .normal)
    }
    
    @objc func sendTapNotification() {
        self.delegate?.requirementButtonTapped(requirement: classRequirement, button: self)
    }
}
