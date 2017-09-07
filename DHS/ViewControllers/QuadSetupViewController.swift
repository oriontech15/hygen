//
//  QuadSetupViewController.swift
//  DHS
//
//  Created by Justin Smith on 8/30/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class QuadSetupViewController: UIViewController {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var minusButton: CustomButton!
    @IBOutlet weak var plusButton: CustomButton!
    
    var patient: Patient!

    var quadCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.numberLabel.text = "\(patient.quads)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func minusButtonTapped() {
        quadCount -= 1
        updateLabel()
    }
    
    @IBAction func plusButtonTapped() {
        quadCount += 1
        updateLabel()
    }
    
    func updateLabel() {
        self.numberLabel.text = "\(quadCount)"
    }
    
    @IBAction func createButtonTapped() {
        PatientsController.shared.updateQuadsFor(patient: self.patient, quads: self.quadCount)
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
