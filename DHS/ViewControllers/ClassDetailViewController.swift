//
//  ClassDetailViewController.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ClassDetailViewController: UIViewController {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: CustomBackButton!
    
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var progressView: CircleProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var gradientView: GradientView!
    
    var className: RequirementType!
    var requirement: Requirement!
    var color: UIColor!
    var patients: [Patient] = []
    
    private var lastContentOffset: CGFloat = 0
    var oldContentOffset = CGPoint.zero
    let topConstraintRange = (CGFloat(60)..<CGFloat(248))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.classNameLabel.text = className.rawValue
        PatientsController.shared.patientsWithClassName(classType: self.className, completion: { (patients) in
            
            self.patients = patients
            self.tableView.reloadData()
        })
        
        updateProgress()
        
        self.backButton.className = className!
        
        switch className! {
        case .class1A:
            self.progressView.progressColors = UIColor.purpleGradientColors()
            self.gradientView.fromColors = UIColor.purpleGradientColorsSemiAlpha()
            self.gradientView.toColors = UIColor.purpleGradientColorsAlmostAlpha()
            self.color = UIColor.myPurple()
            break
        case .class1B:
            self.progressView.progressColors = UIColor.orangeGradientColors()
            self.gradientView.fromColors = UIColor.orangeGradientColorsSemiAlpha()
            self.gradientView.toColors = UIColor.orangeGradientColorsAlmostAlpha()
            self.color = UIColor.myOrange()
            break
        case .class2:
            self.progressView.progressColors = UIColor.greenGradientColors()
            self.gradientView.fromColors = UIColor.greenGradientColorsSemiAlpha()
            self.gradientView.toColors = UIColor.greenGradientColorsAlmostAlpha()
            self.color = UIColor.myGreen()
            break
        case .class3:
            self.progressView.progressColors = UIColor.blueGradientColors()
            self.gradientView.fromColors = UIColor.blueGradientColorsSemiAlpha()
            self.gradientView.toColors = UIColor.blueGradientColorsAlmostAlpha()
            self.color = UIColor.myBlue()
            break
        case .class4:
            self.progressView.progressColors = UIColor.redGradientColors()
            self.gradientView.fromColors = UIColor.redGradientColorsSemiAlpha()
            self.gradientView.toColors = UIColor.redGradientColorsAlmostAlpha()
            self.color = UIColor.myRed()
            break
        case .class5:
            self.progressView.progressColors = UIColor.yellowGradientColors()
            self.gradientView.fromColors = UIColor.yellowGradientColorsSemiAlpha()
            self.gradientView.toColors = UIColor.yellowGradientColorsAlmostAlpha()
            self.color = UIColor.myYellow()
            break
        case .defaultClass:
            break
        default:
            break
        }
    }
    
    func updateProgress() {
        var totalComplete: Int = 0
        let overallTotal: Int = Int(requirement.total)
        for patient in patients {
            if patient.requirementComplete {
                totalComplete += 1
            }
        }
        
        if totalComplete > 0 {
            let totalProgress = ProgressController.shared.calcProgress(currentTotal: totalComplete, total: overallTotal)
            
            let angle = ProgressController.shared.convertProgressToDegrees(progress: totalProgress)
            let percent = ProgressController.shared.convertProgressToPercent(degrees: angle)
            progressLabel.text = "\(percent)%"
            progressView.animate(toAngle: angle, duration: 1.0, completion: nil)
        } else {
            progressLabel.text = "0%"
            progressView.angle = 0
        }
        
        RequirementController.shared.updateRequirementCurrentTotal(newCurrentTotal: Int64(totalComplete), type: className)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        PatientsController.shared.patientsWithClassName(classType: self.className, completion: { (patients) in
            
            self.patients = patients
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var selectedPatient: Patient!
    
    func cellTapped() {
        self.performSegue(withIdentifier: "toPatientDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPatientDetail" {
            if let vc = segue.destination as? PatientDetailTableViewController {
                vc.patient = selectedPatient
            }
        }
    }
}

extension ClassDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath) as? PatientTableViewCell
        
        let patient = patients[indexPath.row]
        cell?.updateWith(patient: patient, color: self.color)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let patient = self.patients[indexPath.row]
        self.selectedPatient = patient
        self.cellTapped()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let patient = patients[indexPath.row]

            let alert = UIAlertController(title: "Delete?", message: "Please confirm you would like to delete \(patient.firstName)", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                self.tableView.beginUpdates()
                PatientsController.shared.removePatient(patient: patient, confirm: true)
                tableView.deleteRows(at: [indexPath], with: .middle)
                self.tableView.endUpdates()
            })
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            self.present(alert, animated: true, completion: nil)
        }
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
