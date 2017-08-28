//
//  NoPatientsTableViewCell.swift
//  DHS
//
//  Created by Justin Smith on 8/18/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class NoPatientsTableViewCell: UITableViewCell {
    
    var type: String = "" {
        didSet {
            setupView()
        }
    }
    
    @IBOutlet weak var noPatientLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        self.noPatientLabel.text = "Currently no patients with recorded \(type)"
    }
}
