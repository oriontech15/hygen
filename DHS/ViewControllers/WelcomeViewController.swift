//
//  WelcomeViewController.swift
//  DHS
//
//  Created by Justin Smith on 6/13/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonTapped() {
        if let name = nameTextField.text, nameTextField.text != "" {
            if let user = UserController.shared.createUser(name: name) {
                print(user.name!)
                self.performSegue(withIdentifier: "toColorPickerView", sender: nil)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nameTextField.resignFirstResponder()
        return true
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
