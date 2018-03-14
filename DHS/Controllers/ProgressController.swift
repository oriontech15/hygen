//
//  ProgressController.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation

class ProgressController {
    
    static let shared = ProgressController()
    
    var overallProgress: Double = 0
    var panoProgress: Double = 0
    var paProgress: Double = 0
    var bwxProgress: Double = 0
    var injectionsProgress: Double = 0
    var class1AProgress: Double = 0
    var class1BProgress: Double = 0
    var class2Progress: Double = 0
    var class3_4Progress: Double = 0
    var class5Progress: Double = 0
    
    var totalCurrentPano: Int64 = 0
    var totalCurrentBWX: Int64 = 0
    var totalCurrentPA: Int64 = 0
    var totalCurrentInjections: Int64 = 0
    var totalCurrentClass1A: Int64 = 0
    var totalCurrentClass1B: Int64 = 0
    var totalCurrentClass2: Int64 = 0
    var totalCurrentClass3_4: Int64 = 0
    var totalCurrentClass5: Int64 = 0
    var totalCurrentOverall: Int64 = 0
    
    var totalPano: Int64 = 0
    var totalBWX: Int64 = 0
    var totalPA: Int64 = 0
    var totalInjections: Int64 = 0
    var totalClass1A: Int64 = 0
    var totalClass1B: Int64 = 0
    var totalClass2: Int64 = 0
    var totalClass3_4: Int64 = 0
    var totalClass5: Int64 = 0
    var totalOverall: Int64 = 0
    
    func calcProgress(currentTotal: Int, total: Int) -> Double {
        let progress = Double(currentTotal) / Double(total)
        if progress >= 1.0 {
            return 1.0
        } else {
            return progress
        }
    }
    
    func convertProgressToPercent(degrees: Double) -> Int {
        return Int(degrees / 3.6)
    }
    
    func convertProgressToDegrees(progress: Double) -> Double {
        return progress * 360
    }
    
    func updatedProgress() {
        let patients = PatientsController.shared.patients
        
        self.totalCurrentPano = 0
        self.totalCurrentBWX = 0
        self.totalCurrentPA = 0
        self.totalCurrentInjections = 0
        self.totalCurrentClass1A = 0
        self.totalCurrentClass1B = 0
        self.totalCurrentClass2 = 0
        self.totalCurrentClass3_4 = 0
        self.totalCurrentClass5 = 0
        
        let panoRequirementTotal: Int64 = RequirementController.shared.pano.total
        let bwxRequirementTotal: Int64 = RequirementController.shared.bwx.total
        let paRequirementTotal: Int64 = RequirementController.shared.pa.total
        let injectionsRequirementTotal: Int64 = RequirementController.shared.injections.total
        let class1ARequirementTotal: Int64 = RequirementController.shared.class1A.total
        let class1BRequirementTotal: Int64 = RequirementController.shared.class1B.total
        let class2RequirementTotal: Int64 = RequirementController.shared.class2.total
        let class3_4RequirementTotal: Int64 = RequirementController.shared.class3.total
        let class5RequirementTotal: Int64 = RequirementController.shared.class5.total
        let overallRequirementTotal: Int64 = class1ARequirementTotal + class1BRequirementTotal + class2RequirementTotal + class3_4RequirementTotal + class5RequirementTotal + panoRequirementTotal + bwxRequirementTotal + paRequirementTotal + injectionsRequirementTotal
        
        self.totalPano = panoRequirementTotal
        self.totalBWX = bwxRequirementTotal
        self.totalPA = paRequirementTotal
        self.totalInjections = injectionsRequirementTotal
        self.totalClass1A = class1ARequirementTotal
        self.totalClass1B = class1BRequirementTotal
        self.totalClass2 = class2RequirementTotal
        self.totalClass3_4 = class3_4RequirementTotal
        self.totalClass5 = class5RequirementTotal
        self.totalOverall = overallRequirementTotal
        
        print("\n--------------------- TOTALS ----------------------")
        print("Class 1A TOTAL: --> \(class1ARequirementTotal)")
        print("Class 1B TOTAL: --> \(class1BRequirementTotal)")
        print("Class 2 TOTAL: --> \(class2RequirementTotal)")
        print("Class 3 TOTAL: --> \(class3_4RequirementTotal)")
        print("Class 4 TOTAL: --> \(class3_4RequirementTotal)")
        print("Class 5 TOTAL: --> \(class5RequirementTotal)")
        print("Pano TOTAL: --> \(panoRequirementTotal)")
        print("BWX TOTAL: --> \(bwxRequirementTotal)")
        print("PA TOTAL: --> \(paRequirementTotal)")
        print("Injection TOTAL: --> \(injectionsRequirementTotal)")
        print("\nOVERALL TOTAL: --> \(overallRequirementTotal)")
        print("--------------------- END TOTALS ----------------------\n")
        
        for patient in patients {
            print("\n--_---------- INJECTIONS -----------_--")
            print("\(patient.firstName) ----> \(patient.injectionsOn)")
            if patient.injectionsOn {
                totalCurrentInjections += Int64(patient.injections)
                print("\(patient.firstName) ----> \(patient.injections)")
            }
            
            if let xrays = patient.xrays?.allObjects as? [Xray] {
                for xray in xrays {
                    if xray.pano {
                        self.totalCurrentPano += 1
                    } else if xray.bwx {
                        self.totalCurrentBWX += 1
                    } else if xray.pa {
                        self.totalCurrentPA += Int64(xray.paNumber)
                    }
                }
            }
            
            switch patient.requirement.type {
            case RequirementType.class1A.rawValue:
                self.totalCurrentClass1A += patient.quads
                break
            case RequirementType.class1B.rawValue:
                print(patient.quads)
                self.totalCurrentClass1B += patient.quads
                break
            case RequirementType.class2.rawValue:
                self.totalCurrentClass2 += patient.quads
                break
            case RequirementType.class3.rawValue:
                self.totalCurrentClass3_4 += patient.quads
                break
            case RequirementType.class4.rawValue:
                self.totalCurrentClass3_4 += patient.quads
                break
            case RequirementType.class5.rawValue:
                self.totalCurrentClass5 += patient.quads
                break
            default:
                break
            }
        }
        
        let totalCurrentOverall: Int64 = self.totalCurrentClass1A + self.totalCurrentClass1B + self.totalCurrentClass2 + self.totalCurrentClass3_4 + self.totalCurrentClass5 + totalCurrentPano + totalCurrentPA + totalCurrentBWX + totalCurrentInjections
        
        self.totalCurrentOverall = totalCurrentOverall
        
        self.overallProgress = calcProgress(currentTotal: Int(totalCurrentOverall), total: Int(overallRequirementTotal))
        self.class1AProgress = calcProgress(currentTotal: Int(self.totalCurrentClass1A), total: Int(class1ARequirementTotal))
        self.class1BProgress = calcProgress(currentTotal: Int(self.totalCurrentClass1B), total: Int(class1BRequirementTotal))
        self.class2Progress = calcProgress(currentTotal: Int(self.totalCurrentClass2), total: Int(class2RequirementTotal))
        self.class3_4Progress = calcProgress(currentTotal: Int(self.totalCurrentClass3_4), total: Int(class3_4RequirementTotal))
        self.class5Progress = calcProgress(currentTotal: Int(self.totalCurrentClass5), total: Int(class5RequirementTotal))
        self.panoProgress = calcProgress(currentTotal: Int(self.totalCurrentPano), total: Int(panoRequirementTotal))
        self.bwxProgress = calcProgress(currentTotal: Int(self.totalCurrentBWX), total: Int(bwxRequirementTotal))
        self.paProgress = calcProgress(currentTotal: Int(self.totalCurrentPA), total: Int(paRequirementTotal))
        self.injectionsProgress = calcProgress(currentTotal: Int(self.totalCurrentInjections), total: Int(injectionsRequirementTotal))
        
        print("\n--------------------- CURRENT ----------------------")
        print("Class 1A CURRENT: --> \(totalCurrentClass1A)")
        print("Class 1B CURRENT: --> \(totalCurrentClass1B)")
        print("Class 2 CURRENT: --> \(totalCurrentClass2)")
        print("Class 3 CURRENT: --> \(totalCurrentClass3_4)")
        print("Class 4 CURRENT: --> \(totalCurrentClass3_4)")
        print("Class 5 CURRENT: --> \(totalCurrentClass5)")
        print("Pano CURRENT: --> \(totalCurrentPano)")
        print("BWX CURRENT: --> \(totalCurrentBWX)")
        print("PA CURRENT: --> \(totalCurrentPA)")
        print("Injection CURRENT: --> \(totalCurrentInjections)")
        print("\nOVERALL CURRENT: --> \(totalCurrentOverall)")
        print("--------------------- END CURRENT ----------------------\n")
        
        print("\n--------------------- OVERVIEW OF PROGRESS ----------------------")
        print("Class 1A: \(totalCurrentClass1A) / \(class1ARequirementTotal) -@- \(class1AProgress)")
        print("Class 1B: \(totalCurrentClass1B) / \(class1BRequirementTotal) -@- \(class1BProgress)")
        print("Class 2: \(totalCurrentClass2) / \(class2RequirementTotal) -@- \(class2Progress)")
        print("Class 3_4: \(totalCurrentClass3_4) / \(class3_4RequirementTotal) -@- \(class3_4Progress)")
        print("Class 5: \(totalCurrentClass5) / \(class5RequirementTotal) -@- \(class5Progress)")
        print("PANO: \(totalCurrentPano) / \(panoRequirementTotal) -@- \(panoProgress)")
        print("BWX: \(totalCurrentBWX) / \(bwxRequirementTotal) -@- \(bwxProgress)")
        print("PA: \(totalCurrentPA) / \(paRequirementTotal) -@- \(paProgress)")
        print("Injections: \(totalCurrentInjections) / \(injectionsRequirementTotal) -@- \(injectionsProgress)")
        print("OVERALL: \(totalCurrentOverall) / \(overallRequirementTotal) -@- \(overallProgress)")
        print("--------------------- END OVERVIEW OF PROGRESS ----------------------\n")
    }
}
