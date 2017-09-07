//
//  AddXrayTableViewCell.swift
//  DHS
//
//  Created by Justin Smith on 8/29/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

protocol AddXrayButtonDelegate {
    func addXrayButtonTapped()
}

class AddXrayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addXrayButton: CustomButton!
    
    var delegate: AddXrayButtonDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update() {
        addXrayButton.setTitleColor(AppearanceController.shared.mainColor, for: .normal)
    }
    
    @IBAction func addXrayButtonTapped() {
        self.delegate?.addXrayButtonTapped()
    }

}
