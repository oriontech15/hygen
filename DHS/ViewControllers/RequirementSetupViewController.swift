//
//  ViewController.swift
//  DHS
//
//  Created by Justin Smith on 6/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class RequirementSetupViewController: UIViewController, RequirementButtonDelegate, NumPadDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var numPadCenterY: NSLayoutConstraint!
    @IBOutlet weak var numPadView: NumPad!
    @IBOutlet weak var doneButton: CustomButton!
    
    var activeRequirement: Requirement!
    
    var closestCellIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _ = self.view
        
        numPadView.delegate = self
        self.doneButton.backgroundColor = AppearanceController.shared.mainColor
        
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        _ = RequirementController.shared.createRequirements({_,_,_  in})
        self.collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.doneButton.setTitle("Save", for: .normal)
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkValues()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var activeButton: RequirementTotalButton!
    
    func numPadFinished(total: Int?) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            self.numPadCenterY.constant = 600
            self.view.layoutIfNeeded()
            self.doneButton.active = true
        }, completion: nil)
        self.collectionView.isUserInteractionEnabled = true
        if total != nil {
            RequirementController.shared.updateRequirementTotal(newTotal: Int64(total!), requirement: activeRequirement)
            self.activeButton.setTitle("\(activeRequirement.total)", for: .normal)
            checkValues()
        } else {
            displayErrorMessage(error: "Error", message: "Please enter a valid number")
        }
    }
    
    func displayErrorMessage(error: String, message: String) {
        let alert = UIAlertController(title: error, message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
    
    func requirementButtonTapped(requirement: Requirement, button: RequirementTotalButton) {
        self.activeButton = button
        self.activeRequirement = requirement
        self.collectionView.isUserInteractionEnabled = false
        self.doneButton.active = false
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            self.numPadCenterY.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    var canProceed: Bool = false
    
    func checkValues() {
        let requirements = RequirementController.shared.allRequirements
        for requirement in requirements {
            if requirement.total > 0 {
                canProceed = true
            } else {
                canProceed = false
                self.doneButton.isEnabled = false
                self.doneButton.backgroundColor = UIColor.myLightGray().withAlphaComponent(0.6)
                return
            }
        }
        
        if canProceed {
            self.doneButton.isEnabled = true
            self.doneButton.backgroundColor = AppearanceController.shared.mainColor
        } else {
            self.doneButton.isEnabled = false
            self.doneButton.backgroundColor = UIColor.myLightGray().withAlphaComponent(0.6)
        }
    }
    
    @IBAction func doneButtonTapped(sender: CustomButton) {
        if canProceed {
            if RequirementController.shared.allRequirements.count == 10 {
                if(canPerformSegueWithIdentifier(identifier: "toMain")) {
                    self.performSegue(withIdentifier: "toMain", sender: nil)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            displayErrorMessage(error: "Requirement Totals Not Configured", message: "Please make sure that each Class Requirement has a valid number")
        }
    }
    
    func canPerformSegueWithIdentifier(identifier: NSString) -> Bool {
        if let templates:NSArray = self.value(forKey: "storyboardSegueTemplates") as? NSArray {
            let predicate:NSPredicate = NSPredicate(format: "identifier=%@", identifier)
            
            let filteredtemplates = templates.filtered(using: predicate)
            return (filteredtemplates.count>0)
        } else {
            return false
        }
    }
}

extension RequirementSetupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RequirementController.shared.allTrackedRequirements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "requirementCell", for: indexPath) as? RequirementCollectionViewCell
        
        cell?.requirementTotalButton.delegate = self
        
        let requirement = RequirementController.shared.allTrackedRequirements[indexPath.row]
        switch indexPath.item {
        case 0:
            cell?.updateWith(requirementType: .class1A, requirement: requirement, textColor: .white)
            break
        case 1:
            cell?.updateWith(requirementType: .class1B, requirement: requirement, textColor: .white)
            break
        case 2:
            cell?.updateWith(requirementType: .class2, requirement: requirement, textColor: .white)
            break
        case 3:
            cell?.updateWith(requirementType: .class3, requirement: requirement, textColor: .white)
            break
        case 4:
            cell?.updateWith(requirementType: .class5, requirement: requirement, textColor: .white)
            break
        case 5:
            cell?.updateWith(requirementType: .pano, requirement: requirement, textColor: UIColor.myGray())
            break
        case 6:
            cell?.updateWith(requirementType: .bwx, requirement: requirement, textColor: UIColor.myGray())
            break
        case 7:
            cell?.updateWith(requirementType: .pa, requirement: requirement, textColor: UIColor.myGray())
            break
        case 8:
            cell?.updateWith(requirementType: .injection, requirement: requirement, textColor: UIColor.myGray())
            break
        default:
            break
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollToNearestVisibleCollectionViewCell()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollToNearestVisibleCollectionViewCell()
    }
    
    func scrollToNearestVisibleCollectionViewCell() {
        let visibleCenterPositionOfScrollView = Float(collectionView.contentOffset.x + (self.collectionView!.bounds.size.width / 2))
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<collectionView.visibleCells.count {
            let cell = collectionView.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            
            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = collectionView.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.collectionView!.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
        print(closestCellIndex)
    }
}

