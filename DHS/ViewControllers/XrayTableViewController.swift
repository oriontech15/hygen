//
//  XrayTableViewController.swift
//  DHS
//
//  Created by Justin Smith on 8/30/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class XrayTableViewController: UITableViewController, AddXrayButtonDelegate {
    
    var patient: Patient!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var selectedIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = "\(patient.firstName) \(patient.lastName)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addXrayButtonTapped() {
        self.performSegue(withIdentifier: "toCreateXray", sender: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let xrays = patient.xrays {
            if xrays.count == 0 {
                return 1
            } else if xrays.count <= 2 {
                return xrays.count + 1
            } else {
                return xrays.count
            }
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let xrays = patient.xrays?.toXrays {
            switch xrays.count {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "addXrayCell", for: indexPath) as? AddXrayTableViewCell
                cell?.delegate = self
                cell?.update()
                return cell ?? UITableViewCell()
            case 1:
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "xrayCell", for: indexPath) as? XraySimpleTableViewCell
                    let xray = xrays[indexPath.row]
                    cell?.updateWith(xray: xray)
                    return cell ?? UITableViewCell()
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "addXrayCell", for: indexPath) as? AddXrayTableViewCell
                    cell?.delegate = self
                    cell?.update()
                    return cell ?? UITableViewCell()
                }
            case 2:
                if indexPath.row == 0 || indexPath.row == 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "xrayCell", for: indexPath) as? XraySimpleTableViewCell
                    let xray = xrays[indexPath.row]
                    cell?.updateWith(xray: xray)
                    return cell ?? UITableViewCell()
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "addXrayCell", for: indexPath) as? AddXrayTableViewCell
                    cell?.delegate = self
                    cell?.update()
                    return cell ?? UITableViewCell()
                }
            case 3:
                if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "xrayCell", for: indexPath) as? XraySimpleTableViewCell
                    let xray = xrays[indexPath.row]
                    cell?.updateWith(xray: xray)
                    return cell ?? UITableViewCell()
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "addXrayCell", for: indexPath) as? AddXrayTableViewCell
                    cell?.delegate = self
                    cell?.update()
                    return cell ?? UITableViewCell()
                }
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "addXrayCell", for: indexPath) as? AddXrayTableViewCell
                cell?.delegate = self
                cell?.update()
                return cell ?? UITableViewCell()
            }
        } else {
            return UITableViewCell()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        if let _ = tableView.cellForRow(at: indexPath) as? XraySimpleTableViewCell {
            self.performSegue(withIdentifier: "toEditXray", sender: nil)
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if let xrays = patient.xrays?.toXrays {
                let xray = xrays[indexPath.row]
            
                let alert = UIAlertController(title: "Delete?", message: "Please confirm you would like to delete this xray)", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                    self.tableView.beginUpdates()
                    XrayController.shared.deleteXray(xray: xray)
                    tableView.deleteRows(at: [indexPath], with: .middle)
                    self.tableView.endUpdates()
                })
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateXray" {
            if let vc = segue.destination as? CreateXrayViewController {
                vc.xray = nil
                vc.patient = self.patient
            }
        } else if segue.identifier == "toEditXray" {
            if let vc = segue.destination as? CreateXrayViewController {
                if let xrays = patient.xrays?.allObjects as? [Xray] {
                    let xray = xrays[selectedIndexPath.row]
                    vc.xray = xray
                    vc.patient = self.patient
                }
            }
        }
    }
}
