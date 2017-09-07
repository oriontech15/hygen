//
//  ScheduleMainViewController.swift
//  DHS
//
//  Created by Justin Smith on 7/20/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

protocol TodayButtonDelegate {
    func todayButtonTapped()
}

class ScheduleMainViewController: UIViewController /*CalendarUpdatedDelegate*/ {

    @IBOutlet weak var toggleSegmentedControl: UISegmentedControl!
    @IBOutlet weak var currentDayButton: UIBarButtonItem!
    @IBOutlet weak var contentView: UIView!
    
    
    @IBOutlet var tabButtons: [UIButton]!
    
    var delegate: TodayButtonDelegate?
    
    var selectedPatient: Patient!
    var selectedDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = UserController.shared.currentUser, let colorName = user.colorName {
            AppearanceController.shared.mainColorName = MainColorName(rawValue: colorName)!
            print(AppearanceController.shared.mainColorName.rawValue)
            
            for button in tabButtons {
                button.setNeedsDisplay()
            }
        }
        
        navigationController?.navigationBar.tintColor = AppearanceController.shared.mainColor
        
        toggleSegmentedControl.tintColor = AppearanceController.shared.mainColor
        currentDayButton.tintColor = AppearanceController.shared.mainColor
        
        toggleSegmentedControl.selectedSegmentIndex = TabIndex.firstChildTab.rawValue
        displayCurrentTab(TabIndex.firstChildTab.rawValue)
    }

    enum TabIndex : Int {
        case firstChildTab = 0
        case secondChildTab = 1
    }
    
    var currentViewController: UIViewController?
    lazy var secondChildTabVC: UIViewController? = {
        let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "calendarVC")
//        self.delegate = secondChildTabVC
//        secondChildTabVC?.delegate = self
        return secondChildTabVC
    }()
    
    lazy var firstChildTabVC : UIViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "listVC") as? ScheduleTableViewController
        firstChildTabVC?.firstLoad = true
        return firstChildTabVC
    }()
    
    // MARK: - View Controller Lifecycle
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Switching Tabs Functions
    @IBAction func switchTabs(_ sender: UISegmentedControl) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    @IBAction func todayButtonTapped() {
        self.delegate?.todayButtonTapped()
    }
    
    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.contentView.bounds
            if let scheduleVC = vc as? ScheduleTableViewController {
                scheduleVC.firstLoad = true
            }
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.firstChildTab.rawValue :
            vc = firstChildTabVC
        case TabIndex.secondChildTab.rawValue :
            vc = secondChildTabVC
        default:
            return nil
        }
        
        return vc
    }
    
    func dateSelected(date: Date) {
        self.selectedDate = date
    }
    
    @IBAction func overallButtonTapped(sender: UIButton) {
        self.performSegue(withIdentifier: "toProgressSwitcher", sender: nil)
    }
    
    @IBAction func createButtonPressed(sender: UIButton) {
        self.performSegue(withIdentifier: "toCreateView", sender: nil)
    }
    
    @IBAction func addButtonTapped() {
        self.performSegue(withIdentifier: "toCreateView", sender: nil)
    }
    
    let slideAnimatorTop = SlideAnimatorTop()
    let slideAnimatorLeft = SlideAnimatorLeftRight(left: true)
    let slideAnimatorRight = SlideAnimatorLeftRight(left: false)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CreatePatientViewController {
            destination.transitioningDelegate = slideAnimatorTop
            destination.date = self.selectedDate ?? Date()
        }
        
        if let destination = segue.destination as? ProgressSwitcherViewController {
            destination.transitioningDelegate = slideAnimatorLeft
        }
    }
}
