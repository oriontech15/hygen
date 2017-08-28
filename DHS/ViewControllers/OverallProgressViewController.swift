//
//  OverallProgressViewController.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class OverallProgressViewController: UIViewController {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var progressView: CircleProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    private var lastContentOffset: CGFloat = 0
    var oldContentOffset = CGPoint.zero
    let topConstraintRange = (CGFloat(60)..<CGFloat(248))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = UserController.shared.currentUser, let colorName = user.colorName {
            AppearanceController.shared.mainColorName = MainColorName(rawValue: colorName)!
            print(AppearanceController.shared.mainColorName.rawValue)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateProgress()
    }
    
    func updateProgress() {
        
        let totalProgress = ProgressController.shared.overallProgress
        updateProgressOnView(label: self.progressLabel, view: progressView, progress: totalProgress)
    
        ProgressController.shared.updatedProgress()

        self.tableView.reloadData()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func requirementSetupButtonTapped() {
        self.performSegue(withIdentifier: "toRequirementSetup", sender: nil)
    }
    
    @IBAction func overallButtonTapped(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let slideAnimatorTop = SlideAnimatorTop()
    let slideAnimatorLeft = SlideAnimatorLeftRight(left: true)
    let slideAnimatorRight = SlideAnimatorLeftRight(left: false)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, let sender = sender as? RequirementTableViewCell {
            if identifier == "toClassDetail" {
                if let indexPath = tableView.indexPath(for: sender) {
                    if let nc = segue.destination as? UINavigationController {
                        if let vc = nc.viewControllers[0] as? ClassDetailViewController {
                            vc.className = RequirementType(rawValue: RequirementController.shared.classRequirements[indexPath.row].type)
                            vc.requirement = RequirementController.shared.classRequirements[indexPath.row]
                        }
                    }
                }
            }
        }
        
        if let destination = segue.destination as? CreatePatientViewController {
            destination.transitioningDelegate = slideAnimatorTop
        }
        
        if segue.identifier == "toCalendarView" {
            if let destination = segue.destination as? UINavigationController {
                destination.transitioningDelegate = slideAnimatorRight
            }
        }
    }
}

extension OverallProgressViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RequirementController.shared.classRequirements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath) as? RequirementTableViewCell
        let requirement = RequirementController.shared.classRequirements[indexPath.row]
        print(requirement.type)
        cell?.updateWith(requirement: requirement)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toClassDetail", sender: tableView.cellForRow(at: indexPath))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta =  scrollView.contentOffset.y - oldContentOffset.y
        
        //we compress the top view
        if delta > 0 && topConstraint.constant > topConstraintRange.lowerBound && scrollView.contentOffset.y > 0 {
            topConstraint.constant -= delta
        }
        
        //we expand the top view
        if delta < 0 && topConstraint.constant < topConstraintRange.upperBound && scrollView.contentOffset.y < 0 {
            topConstraint.constant -= delta
        }
        
        oldContentOffset = scrollView.contentOffset
    }
}
