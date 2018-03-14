////
////  ViewController.swift
////  CalendarTest
////
////  Created by Justin Smith on 7/18/17.
////  Copyright © 2017 com.example. All rights reserved.
////
//
//import UIKit
//
//protocol CalendarUpdatedDelegate {
//    func dateSelected(date: Date)
//}
//
//class CalendarViewController: UIViewController, TodayButtonDelegate {
//    
//    @IBOutlet weak var menuView: CVCalendarMenuView!
//    @IBOutlet weak var calendarView: CVCalendarView!
//    @IBOutlet weak var monthLabel: UILabel!
//    @IBOutlet weak var seperatorView: RoundedView!
//    @IBOutlet weak var tableView: UITableView!
//    
//    var animationFinished = true
//    
//    var patientsForDate: [Patient] = []
//    var selectedDate: NSDate!
//    
//    var previousDayView: DayView!
//    var selectedPatient: Patient!
//    
//    var delegate: CalendarUpdatedDelegate?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        monthLabel.text = CVDate(date: Date()).globalDescription
//        selectedDate = NSDate()
//        
//        seperatorView.backgroundColor = UIColor.colorFromCode(0x11b1b3)
//        tableView.contentInset = UIEdgeInsetsMake(0, 0, 65, 0)
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }
//    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//    }
//    
//    func todayButtonTapped() {
//        calendarView.toggleViewWithDate(Date())
//    }
//    
//    func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool) {
//        if previousDayView != nil {
//            previousDayView.setupDotMarker(option: true)
//            previousDayView = dayView
//            dayView.setupDotMarker(option: false)
//        } else {
//            self.previousDayView = dayView
//            dayView.setupDotMarker(option: false)
//        }
//        
//        if let date = dayView.date.convertedDate() {
//            self.selectedDate = date as NSDate
//            self.delegate?.dateSelected(date: date)
//            self.patientsForDate = PatientsController.shared.getPatientsWithDate(date: date as NSDate)
//            self.tableView.reloadData()
//        }
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        menuView.commitMenuViewUpdate()
//        calendarView.commitCalendarViewUpdate()
//        self.patientsForDate = PatientsController.shared.getPatientsWithDate(date: selectedDate)
//        self.tableView.reloadData()
//        
//        calendarView.setNeedsDisplay()
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toPatientDetail" {
//            if let vc = segue.destination as? PatientDetailTableViewController {
//                
//                vc.patient = selectedPatient
//            }
//        }
//    }
//}
//
//extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return PatientsController.shared.getPatientsWithDate(date: selectedDate).count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentCell", for: indexPath) as? AppointmentTableViewCell
//        
//        let patients = PatientsController.shared.getPatientsWithDate(date: selectedDate)
//        
//        var cellLocation: CellLocation = .neither
//        
//        if indexPath.row == 0 && patients.count == 1 {
//            cellLocation = .off
//        } else if indexPath.row == 0 && patients.count > 1{
//            cellLocation = .first
//        } else if indexPath.row == (patients.count - 1) {
//            cellLocation = .last
//        } else {
//            cellLocation = .neither
//        }
//        
//        let patient = patients[indexPath.row]
//        cell?.updateWith(patient: patient, cellLocation: cellLocation)
//        
//        return cell ?? UITableViewCell()
//    }
//    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
//    {
//        return true
//    }
//    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
//    {
//        if editingStyle == .delete
//        {
//            let patient = PatientsController.shared.getPatientsWithDate(date: selectedDate)[indexPath.row]
//            
//            let alert = UIAlertController(title: "Delete?", message: "Please confirm you would like to delete \(patient.firstName)", preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
//                
//                self.tableView.beginUpdates()
//                PatientsController.shared.removePatient(patient: patient, confirm: true)
//                tableView.deleteRows(at: [indexPath], with: .middle)
//                self.tableView.endUpdates()
//            })
//            alert.addAction(cancelAction)
//            alert.addAction(deleteAction)
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let patient = self.patientsForDate[indexPath.row]
//        self.selectedPatient = patient
//        self.performSegue(withIdentifier: "toPatientDetail", sender: nil)
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return selectedDate.toString()
//    }
//}
//
//extension CalendarViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
//    
//    func presentationMode() -> CalendarMode {
//        return .monthView
//    }
//    
//    func firstWeekday() -> Weekday {
//        return .sunday
//    }
//    
//    func shouldShowWeekdaysOut() -> Bool {
//        return true
//    }
//    
//    func presentedDateUpdated(_ date: CVDate) {
//        if monthLabel.text != date.globalDescription && self.animationFinished {
//            let updatedMonthLabel = UILabel()
//            updatedMonthLabel.textColor = monthLabel.textColor
//            updatedMonthLabel.font = monthLabel.font
//            updatedMonthLabel.textAlignment = .center
//            updatedMonthLabel.text = date.globalDescription
//            updatedMonthLabel.sizeToFit()
//            updatedMonthLabel.alpha = 0
//            updatedMonthLabel.center = self.monthLabel.center
//            
//            let offset = CGFloat(48)
//            updatedMonthLabel.transform = CGAffineTransform(translationX: 0, y: offset)
//            updatedMonthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
//            
//            UIView.animate(withDuration: 0.35, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
//                self.animationFinished = false
//                self.monthLabel.transform = CGAffineTransform(translationX: 0, y: -offset)
//                self.monthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
//                self.monthLabel.alpha = 0
//                
//                updatedMonthLabel.alpha = 1
//                updatedMonthLabel.transform = CGAffineTransform.identity
//                
//            }) { _ in
//                
//                self.animationFinished = true
//                self.monthLabel.frame = updatedMonthLabel.frame
//                self.monthLabel.text = updatedMonthLabel.text
//                self.monthLabel.transform = CGAffineTransform.identity
//                self.monthLabel.alpha = 1
//                updatedMonthLabel.removeFromSuperview()
//            }
//            
//            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
//        }
//    }
//    
//    func dotMarker(shouldShowOnDayView dayView: DayView, option: Bool) -> Bool {
//        if !option {
//            return false
//        } else {
//            if !dayView.isCurrentDay {
//                if let date = dayView.date.convertedDate() {
//                    if PatientsController.shared.getPatientsWithDate(date: date as NSDate).count > 0 {
//                        return true
//                    } else {
//                        return false
//                    }
//                } else {
//                    return false
//                }
//            } else {
//                return false
//            }
//        }
//    }
//    
//    func dotMarker(colorOnDayView dayView: DayView) -> [UIColor] {
//        var colors: [UIColor] = []
//        
//        if let date = dayView.date.convertedDate() {
//            let patients = PatientsController.shared.getPatientsWithDate(date: date as NSDate)
//            for (index, patient) in patients.enumerated() {
//                if index <= 2 {
//                    switch patient.requirement.type {
//                    case RequirementType.class1A.rawValue:
//                        colors.append(UIColor.myPurple())
//                        break
//                    case RequirementType.class1B.rawValue:
//                        colors.append(UIColor.myOrange())
//                        break
//                    case RequirementType.class2.rawValue:
//                        colors.append(UIColor.myGreen())
//                        break
//                    case RequirementType.class3.rawValue:
//                        colors.append(UIColor.myBlue())
//                        break
//                    case RequirementType.class4.rawValue:
//                        colors.append(UIColor.myRed())
//                        break
//                    case RequirementType.class5.rawValue:
//                        colors.append(UIColor.myYellow())
//                        break
//                    default:
//                        break
//                    }
//                }
//            }
//        }
//        
//        return colors
//    }
//    
//    func dotMarker(moveOffsetOnDayView dayView: DayView) -> CGFloat {
//        return 12
//    }
//    
//    func topMarker(shouldDisplayOnDayView dayView: DayView) -> Bool {
//        return false
//    }
//}
//
//extension CalendarViewController: CVCalendarViewAppearanceDelegate {
//    
//    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont {
//        if present.rawValue == 0 {
//            return UIFont.boldSystemFont(ofSize: 16)
//        }
//        
//        if status.rawValue == 1 {
//            return UIFont.systemFont(ofSize: 11)
//        } else {
//            return UIFont.systemFont(ofSize: 16)
//        }
//    }
//    
//    func dayLabelWeekdaySelectedBackgroundColor() -> UIColor {
//        return AppearanceController.shared.mainColor
//    }
//    
//    func dayLabelPresentWeekdaySelectedBackgroundColor() -> UIColor {
//        if AppearanceController.shared.mainColor == UIColor(red: 0.992, green: 0.224, blue: 0.333, alpha: 1.00) {
//            return UIColor(red: 0.996, green: 0.765, blue: 0.016, alpha: 1.00)
//        } else {
//            return UIColor.myRed()
//        }
//    }
//    
//    func dayLabelPresentWeekdaySelectedTextColor() -> UIColor {
//        if AppearanceController.shared.mainColor == UIColor(red: 0.992, green: 0.224, blue: 0.333, alpha: 1.00) {
//            return UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1.00)
//        } else {
//            return UIColor.white
//        }
//    }
//    
//    func dayLabelPresentWeekdayTextColor() -> UIColor {
//        return UIColor.colorFromCode(0x00cb59)
//    }
//    
//    func dayLabelPresentWeekdayInitallyBold() -> Bool {
//        return true
//    }
//    
//    func dayLabelPresentWeekdaySelectedFont() -> UIFont {
//        return UIFont.boldSystemFont(ofSize: 18)
//    }
//    
//    func dayLabelPresentWeekdayBoldFont() -> UIFont {
//        return UIFont.boldSystemFont(ofSize: 18)
//    }
//    
//    func dayLabelPresentWeekdayTextSize() -> CGFloat {
//        return 18
//    }
//}
//
//extension CalendarViewController {
//    @IBAction func loadPrevious(sender: AnyObject) {
//        calendarView.loadPreviousView()
//    }
//    
//    
//    @IBAction func loadNext(sender: AnyObject) {
//        calendarView.loadNextView()
//    }
//}
//
