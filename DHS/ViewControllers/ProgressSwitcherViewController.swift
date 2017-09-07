//
//  ProgressSwitcherViewController.swift
//  DHS
//
//  Created by Justin Smith on 8/11/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ProgressSwitcherViewController: UIViewController {
    
    @IBOutlet weak var overallProgressLabel: UILabel!
    @IBOutlet weak var overallProgressView: CircleProgressView!
    @IBOutlet weak var class1AProgressView: CircleProgressView!
    @IBOutlet weak var class1BProgressView: CircleProgressView!
    @IBOutlet weak var class2ProgressView: CircleProgressView!
    @IBOutlet weak var class3ProgressView: CircleProgressView!
    @IBOutlet weak var class4ProgressView: CircleProgressView!
    @IBOutlet weak var class5ProgressView: CircleProgressView!
    
    @IBOutlet weak var panoProgressLabel: UILabel!
    @IBOutlet weak var panoProgressView: CircleProgressView!
    
    @IBOutlet weak var bwxProgressLabel: UILabel!
    @IBOutlet weak var bwxProgressView: CircleProgressView!
    
    @IBOutlet weak var paProgressLabel: UILabel!
    @IBOutlet weak var paProgressView: CircleProgressView!
    
    @IBOutlet weak var injectionsProgressLabel: UILabel!
    @IBOutlet weak var injectionsProgressView: CircleProgressView!
    
    @IBOutlet weak var overallNumbersProgressLabel: UILabel!
    @IBOutlet weak var panoNumbersProgressLabel: UILabel!
    @IBOutlet weak var bwxNumbersProgressLabel: UILabel!
    @IBOutlet weak var paNumbersProgressLabel: UILabel!
    @IBOutlet weak var injectionNumbersProgressLabel: UILabel!
    
    @IBOutlet weak var class1ANameLabel: UILabel!
    @IBOutlet weak var class1BNameLabel: UILabel!
    @IBOutlet weak var class2NameLabel: UILabel!
    @IBOutlet weak var class3NameLabel: UILabel!
    @IBOutlet weak var class4NameLabel: UILabel!
    @IBOutlet weak var class5NameLabel: UILabel!
    
    @IBOutlet var tabButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user = UserController.shared.currentUser, let colorName = user.colorName {
            AppearanceController.shared.mainColorName = MainColorName(rawValue: colorName)!
            print(AppearanceController.shared.mainColorName.rawValue)
            
            updateProgress()
            
            for button in tabButtons {
                button.setNeedsDisplay()
            }
        }
        
        adjustViewLayout(size: UIScreen.main.bounds.size)
    }
    
    func adjustViewLayout(size: CGSize) {
        switch(size.width, size.height) {
        case (320, 480):                        // iPhone 4S in portrait
            break
        case (480, 320):                        // iPhone 4S in landscape
            break
        case (320, 568):                        // iPhone 5/5S in portrait
            self.class1ANameLabel.text = "1A"
            self.class1BNameLabel.text = "1B"
            self.class2NameLabel.text = "2"
            self.class3NameLabel.text = "3"
            self.class4NameLabel.text = "4"
            self.class5NameLabel.text = "5"
            
            self.class1ANameLabel.textAlignment = .center
            self.class1BNameLabel.textAlignment = .center
            self.class2NameLabel.textAlignment = .center
            self.class3NameLabel.textAlignment = .center
            self.class4NameLabel.textAlignment = .center
            self.class5NameLabel.textAlignment = .center
            break
        case (568, 320):                        // iPhone 5/5S in landscape
            break
        case (375, 667):                        // iPhone 6 in portrait
            self.class1ANameLabel.text = "Class 1A"
            self.class1BNameLabel.text = "Class 1B"
            self.class2NameLabel.text = "Class 2"
            self.class3NameLabel.text = "Class 3"
            self.class4NameLabel.text = "Class 4"
            self.class5NameLabel.text = "Class 5"
            break
        case (667, 375):                        // iPhone 6 in landscape
            break
        case (414, 736):                        // iPhone 6 Plus in portrait
            break
        case (736, 414):                        // iphone 6 Plus in landscape
            break
        default:
            break
        }
        view.setNeedsLayout()
    }
    
    func updateProgress() {
        
        ProgressController.shared.updatedProgress()
        
        let totalOverallProgress = ProgressController.shared.overallProgress
        print(totalOverallProgress)
        let totalClass1AProgress = ProgressController.shared.class1AProgress
        print(totalClass1AProgress)
        let totalClass1BProgress = ProgressController.shared.class1BProgress
        print(totalClass1BProgress)
        let totalClass2Progress = ProgressController.shared.class2Progress
        print(totalClass2Progress)
        let totalClass3Progress = ProgressController.shared.class3_4Progress
        print(totalClass3Progress)
        let totalClass4Progress = ProgressController.shared.class3_4Progress
        print(totalClass4Progress)
        let totalClass5Progress = ProgressController.shared.class5Progress
        print(totalClass5Progress)
        let totalPanoProgress = ProgressController.shared.panoProgress
        print(totalPanoProgress)
        let totalBWXProgress = ProgressController.shared.bwxProgress
        print(totalBWXProgress)
        let totalPAProgress = ProgressController.shared.paProgress
        print(totalPAProgress)
        let totalInjectionProgress = ProgressController.shared.injectionsProgress
        print(totalInjectionProgress)
        
        overallProgressView.trackColor = AppearanceController.shared.mainColor.withAlphaComponent(0.1)
        class1AProgressView.trackColor = UIColor.myPurple().withAlphaComponent(0.1)
        class1BProgressView.trackColor = UIColor.myOrange().withAlphaComponent(0.1)
        class2ProgressView.trackColor = UIColor.myGreen().withAlphaComponent(0.1)
        class3ProgressView.trackColor = UIColor.myBlue().withAlphaComponent(0.1)
        class4ProgressView.trackColor = UIColor.myRed().withAlphaComponent(0.1)
        class5ProgressView.trackColor = UIColor.myYellow().withAlphaComponent(0.1)
        panoProgressView.trackColor = AppearanceController.shared.mainColor.withAlphaComponent(0.1)
        bwxProgressView.trackColor = AppearanceController.shared.mainColor.withAlphaComponent(0.1)
        paProgressView.trackColor = AppearanceController.shared.mainColor.withAlphaComponent(0.1)
        injectionsProgressView.trackColor = AppearanceController.shared.mainColor.withAlphaComponent(0.1)
        
        overallProgressView.set(colors: AppearanceController.shared.mainColor)
        class1AProgressView.set(colors: UIColor.myPurple())
        class1BProgressView.set(colors: UIColor.myOrange())
        class2ProgressView.set(colors: UIColor.myGreen())
        class3ProgressView.set(colors: UIColor.myBlue())
        class4ProgressView.set(colors: UIColor.myRed())
        class5ProgressView.set(colors: UIColor.myYellow())
        panoProgressView.set(colors: AppearanceController.shared.mainColor)
        bwxProgressView.set(colors: AppearanceController.shared.mainColor)
        paProgressView.set(colors: AppearanceController.shared.mainColor)
        injectionsProgressView.set(colors: AppearanceController.shared.mainColor)
        
        updateProgressOnView(label: self.overallProgressLabel, view: self.overallProgressView, progress: totalOverallProgress)
        updateProgressOnView(label: nil, view: self.class1AProgressView, progress: totalClass1AProgress)
        updateProgressOnView(label: nil, view: self.class1BProgressView, progress: totalClass1BProgress)
        updateProgressOnView(label: nil, view: self.class2ProgressView, progress: totalClass2Progress)
        updateProgressOnView(label: nil, view: self.class3ProgressView, progress: totalClass3Progress)
        updateProgressOnView(label: nil, view: self.class4ProgressView, progress: totalClass4Progress)
        updateProgressOnView(label: nil, view: self.class5ProgressView, progress: totalClass5Progress)
        updateProgressOnView(label: self.panoProgressLabel, view: self.panoProgressView, progress: totalPanoProgress)
        updateProgressOnView(label: self.bwxProgressLabel, view: self.bwxProgressView, progress: totalBWXProgress)
        updateProgressOnView(label: self.paProgressLabel, view: self.paProgressView, progress: totalPAProgress)
        updateProgressOnView(label: self.injectionsProgressLabel, view: self.injectionsProgressView, progress: totalInjectionProgress)
        
        updateNumbersLabel(requirement: "Pano", overall: false)
        updateNumbersLabel(requirement: "BWX", overall: false)
        updateNumbersLabel(requirement: "PA", overall: false)
        updateNumbersLabel(requirement: "Injections", overall: false)
        updateNumbersLabel(requirement: "Overall", overall: true)
        
        self.view.setNeedsDisplay()
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
    
    func updateNumbersLabel(requirement: String, overall: Bool) {
        if overall {
            let overallCurrent = ProgressController.shared.totalCurrentOverall
            let overallTotal = ProgressController.shared.totalOverall
            self.overallNumbersProgressLabel.text = "\(overallCurrent) / \(overallTotal)"
        } else {
            switch requirement {
            case RequirementType.pano.rawValue:
                let panoCurrent = ProgressController.shared.totalCurrentPano
                let panoTotal = ProgressController.shared.totalPano
                self.panoNumbersProgressLabel.text = "\(panoCurrent) / \(panoTotal)"
                break
            case RequirementType.bwx.rawValue:
                let bwxCurrent = ProgressController.shared.totalCurrentBWX
                let bwxTotal = ProgressController.shared.totalBWX
                self.bwxNumbersProgressLabel.text = "\(bwxCurrent) / \(bwxTotal)"
                break
            case RequirementType.pa.rawValue:
                let paCurrent = ProgressController.shared.totalCurrentPA
                let paTotal = ProgressController.shared.totalPA
                self.paNumbersProgressLabel.text = "\(paCurrent) / \(paTotal)"
                break
            case RequirementType.injection.rawValue:
                let injectionCurrent = ProgressController.shared.totalCurrentInjections
                let injectionTotal = ProgressController.shared.totalInjections
                self.injectionNumbersProgressLabel.text = "\(injectionCurrent) / \(injectionTotal)"
                break
            default:
                break
            }
        }
    }
    
    @IBAction func overallProgressTapped() {
        self.performSegue(withIdentifier: "toOverallView", sender: nil)
    }
    
    @IBAction func panoProgressTapped() {
        self.performSegue(withIdentifier: "toPanoView", sender: nil)
    }
    
    @IBAction func bwxProgressTapped() {
        self.performSegue(withIdentifier: "toBWXView", sender: nil)
    }
    
    @IBAction func paProgressTapped() {
        self.performSegue(withIdentifier: "toPAView", sender: nil)
    }
    
    @IBAction func injectionsProgressTapped() {
        self.performSegue(withIdentifier: "toInjectionsView", sender: nil)
    }
    
    @IBAction func calendarButtonTapped(sender: UIButton) {
        self.performSegue(withIdentifier: "toCalendarView", sender: nil)
    }
    
    @IBAction func createButtonPressed(sender: UIButton) {
        self.performSegue(withIdentifier: "toCreateView", sender: nil)
    }
    
    let slideAnimatorTop = SlideAnimatorTop()
    let slideAnimatorLeft = SlideAnimatorLeftRight(left: true)
    let slideAnimatorRight = SlideAnimatorLeftRight(left: false)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
