//
//  XraySimpleTableViewCell.swift
//  DHS
//
//  Created by Justin Smith on 9/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class XraySimpleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var xrayRequirementLabel: UILabel!
    @IBOutlet weak var xrayTypeLabel: UILabel!
    @IBOutlet weak var xrayPa_SetsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateWith(xray: Xray) {
        if xray.pano {
            self.xrayRequirementLabel.text = "Pano"
            self.xrayPa_SetsLabel.isHidden = true
            if xray.cbct {
                self.xrayTypeLabel.text = "CBCT"
            } else if xray.scanx {
                self.xrayTypeLabel.text = "SCAN-X"
            }
        } else if xray.bwx {
            self.xrayRequirementLabel.text = "BWX"
            self.xrayPa_SetsLabel.isHidden = false
            self.xrayPa_SetsLabel.text = "Set: \(xray.sets)"
            if xray.schick {
                self.xrayTypeLabel.text = "SCHICK"
            } else if xray.scanx {
                self.xrayTypeLabel.text = "SCAN-X"
            }
        } else if xray.pa {
            self.xrayRequirementLabel.text = "PA"
            self.xrayPa_SetsLabel.isHidden = false
            self.xrayPa_SetsLabel.text = "PA's: \(xray.paNumber)"
            if xray.schick {
                self.xrayTypeLabel.text = "SCHICK"
            } else if xray.scanx {
                self.xrayTypeLabel.text = "SCAN-X"
            }
        }
    }

}
