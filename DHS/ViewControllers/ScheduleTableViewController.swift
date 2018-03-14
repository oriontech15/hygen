//
//  ScheduleTableViewController.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController {
    
    var patients: [Patient] = []
    var patientDates: [NSDate] = []
    var patientsDict: [String: [Patient]] = [:]
    
    var selectedPatient: Patient!
    
    var firstLoad = true
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ListView"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("FIRST LOAD VALUE: \(firstLoad)")
        if !firstLoad {
            self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 68, 0)
        } else {
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 68, 0)
        }
        
        self.patientDates = PatientsController.shared.getDatesForPatients()
        self.tableView.reloadData()
        
        firstLoad = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
//        if let second = currentViewController as? ScheduleTableViewController {
//            second.firstLoad = true
//        }
        
        self.firstLoad = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPatientDetail" {
            if let vc = segue.destination as? PatientDetailTableViewController {
                
                    vc.patient = selectedPatient
            }
        }
    }
}

// MARK: - Table view data source
extension ScheduleTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return patientDates.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if patientDates.count > 0 {
            let patients = PatientsController.shared.getPatientsWithDate(date: patientDates[section])
            return patients.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentCell", for: indexPath) as? AppointmentTableViewCell
        
        let patients = PatientsController.shared.getPatientsWithDate(date: patientDates[indexPath.section])
        
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let patients = PatientsController.shared.getPatientsWithDate(date: patientDates[indexPath.section])
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let patients = PatientsController.shared.getPatientsWithDate(date: patientDates[indexPath.section])
        let patient = patients[indexPath.row]
        self.selectedPatient = patient
        self.performSegue(withIdentifier: "toPatientDetail", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = patientDates[section]
        return date.toString()
    }
}
