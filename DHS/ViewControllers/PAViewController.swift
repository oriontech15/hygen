//
//  ClassDetailViewController.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class PaViewController: UIViewController {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: CustomBackButton!
    
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var progressView: CircleProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var gradientView: GradientView!
    
    var patientDates: [NSDate] = []
    
    var className: RequirementType!
    //var requirement: Requirement!
    var color: UIColor!
    var patients: [Patient] = []
    
    private var lastContentOffset: CGFloat = 0
    var oldContentOffset = CGPoint.zero
    let topConstraintRange = (CGFloat(60)..<CGFloat(248))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch AppearanceController.shared.mainColorName {
        case .purple:
            self.backButton.className = .class1A
            self.progressView.progressColors = UIColor.purpleGradientColors()
            self.gradientView.fromColors = UIColor.purpleGradientColorsSemiAlpha()
            self.gradientView.toColors = UIColor.purpleGradientColorsAlmostAlpha()
            self.color = UIColor.myPurple()
            break
        case .orange:
            self.backButton.className = .class1B
            self.progressView.progressColors = UIColor.orangeGradientColors()
            self.gradientView.fromColors = UIColor.orangeGradientColorsSemiAlpha()
            self.gradientView.toColors = UIColor.orangeGradientColorsAlmostAlpha()
            self.color = UIColor.myOrange()
            break
        case .green:
            self.backButton.className = .class2
            self.progressView.progressColors = UIColor.greenGradientColors()
            self.gradientView.fromColors = UIColor.greenGradientColorsSemiAlpha()
            self.gradientView.toColors = UIColor.greenGradientColorsAlmostAlpha()
            self.color = UIColor.myGreen()
            break
        case .blue:
            self.backButton.className = .class3
            self.progressView.progressColors = UIColor.blueGradientColors()
            self.gradientView.fromColors = UIColor.blueGradientColorsSemiAlpha()
            self.gradientView.toColors = UIColor.blueGradientColorsAlmostAlpha()
            self.color = UIColor.myBlue()
            break
        case .red:
            self.backButton.className = .class4
            self.progressView.progressColors = UIColor.redGradientColors()
            self.gradientView.fromColors = UIColor.redGradientColorsSemiAlpha()
            self.gradientView.toColors = UIColor.redGradientColorsAlmostAlpha()
            self.color = UIColor.myRed()
            break
        case .yellow:
            self.backButton.className = .class5
            self.progressView.progressColors = UIColor.yellowGradientColors()
            self.gradientView.fromColors = UIColor.yellowGradientColorsSemiAlpha()
            self.gradientView.toColors = UIColor.yellowGradientColorsAlmostAlpha()
            self.color = UIColor.myYellow()
            break
        case .pink:
            self.backButton.className = .defaultClass
            self.progressView.progressColors = UIColor.pinkGradientColors()
            self.gradientView.fromColors = UIColor.pinkGradientColorsSemiAlpha()
            self.gradientView.toColors = UIColor.pinkGradientColorsAlmostAlpha()
            self.color = UIColor.myPink()
            break
        case .white:
            break
        }
    }
    
    func updateProgress() {
        
        let totalProgress = ProgressController.shared.paProgress
        updateProgressOnView(label: self.progressLabel, view: progressView, progress: totalProgress)
        
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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        PatientsController.shared.patientsWithXray(xrayType: .pa, completion: { (patients) in
            
            self.patients = patients
            self.patientDates = PatientsController.shared.getDatesForPatients(patients: patients)
            self.tableView.reloadData()
        })
        
        updateProgress()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
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

extension PaViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if patients.count == 0 {
            return 1
        } else {
            return patientDates.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if patients.count == 0 {
            return 1
        } else {
            if patientDates.count > 0 {
                let patients = PatientsController.shared.getPatientsWithDate(patients: self.patients, date: patientDates[section])
                return patients.count
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.patients.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noPatientsCell", for: indexPath) as? NoPatientsTableViewCell
            cell?.type = "PA's taken"
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentCell", for: indexPath) as? AppointmentTableViewCell
            
            
            let patients = PatientsController.shared.getPatientsWithDate(patients: self.patients, date: patientDates[indexPath.section])
            
            var cellLocation: CellLocation = .neither
            
            if indexPath.row == 0 && patients.count == 1 {
                cellLocation = .off
            } else if indexPath.row == 0 && patients.count > 1{
                cellLocation = .first
            } else if indexPath.row == (patients.count - 1) {
                cellLocation = .last
            } else {
                cellLocation = .neither
            }
            
            let patient = patients[indexPath.row]
            cell?.updateWith(patient: patient, cellLocation: cellLocation)
            
            return cell ?? UITableViewCell()
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let patients = PatientsController.shared.getPatientsWithDate(patients: self.patients, date: patientDates[indexPath.section])
        let patient = patients[indexPath.row]
        self.selectedPatient = patient
        self.performSegue(withIdentifier: "toPatientDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if patients.count == 0 {
            return nil
        } else {
            let date = patientDates[section]
            return date.toString()
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
