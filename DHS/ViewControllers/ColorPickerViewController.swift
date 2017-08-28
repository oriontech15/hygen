//
//  ColorPickerViewController.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController, ColorPickerDelegate {

    @IBOutlet var classButtons: [ColorButton]!
    @IBOutlet weak var doneButton: UIButton!
    
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in self.classButtons {
            button.delegate = self
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func classButtonSelected(sender: UIButton) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        classButtons[previousIndex].notSelected()
        classButtons[selectedIndex].selected()
    }
    
    @IBAction func doneButtonTapped(sender: UIButton) {
        if UserController.shared.currentUser?.colorName != nil {
            self.performSegue(withIdentifier: "toRequirementSetup", sender: nil)
        }
    }
    
    func colorPicked(color: UIColor) {
        self.doneButton.backgroundColor = color
    }
}
