//
//  ClassController.swift
//  DHS
//
//  Created by Justin Smith on 6/12/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import CoreData

class RequirementController {
    
    static let shared = RequirementController()
    
    var class1A: Requirement!
    var class1B: Requirement!
    var class2: Requirement!
    var class3: Requirement!
    var class4: Requirement!
    var class5: Requirement!
    var injections: Requirement!
    var pano: Requirement!
    var bwx: Requirement!
    var pa: Requirement!
    
    lazy var allRequirements: [Requirement] = []
    lazy var allTrackedRequirements: [Requirement] = []
    lazy var classRequirements: [Requirement] = []
    
    init() {
        if UserController.shared.currentUser != nil {
            createRequirements({ (requirements, allTrackedRequirements, classRequirements) in
                if let requirements = requirements {
                    self.allRequirements = requirements
                }
                if let classRequirements = classRequirements {
                    self.classRequirements = classRequirements
                }
                if let allTrackedRequirements = allTrackedRequirements {
                    self.allTrackedRequirements = allTrackedRequirements
                }
            })
        }
    }
    
    func createRequirements(_ completion: (_ allRequirements: [Requirement]?, _ allTrackedRequirements: [Requirement]?, _ classRequirements: [Requirement]?) -> Void) {
        if contextCards().allRequirements.count != 10 {
            var allRequirements: [Requirement] = []
            var allTrackedRequirements: [Requirement] = []
            var classRequirements: [Requirement] = []
            let user = UserController.shared.currentUser
            guard let class1A = Requirement(type: RequirementType.class1A, currentTotal: 0, total: 0, progress: 0, complete: false, user: user!) else { return completion(nil, nil, nil) }
            self.class1A = class1A
            
            guard let class1B = Requirement(type: RequirementType.class1B, currentTotal: 0, total: 0, progress: 0, complete: false, user: user!) else { return completion(nil, nil, nil) }
            self.class1B = class1B
            
            guard let class2 = Requirement(type: RequirementType.class2, currentTotal: 0, total: 0, progress: 0, complete: false, user: user!) else { return completion(nil, nil, nil) }
            self.class2 = class2
            
            guard let class3 = Requirement(type: RequirementType.class3, currentTotal: 0, total: 0, progress: 0, complete: false, user: user!) else { return completion(nil, nil, nil) }
            self.class3 = class3
            
            guard let class4 = Requirement(type: RequirementType.class4, currentTotal: 0, total: 0, progress: 0, complete: false, user: user!) else { return completion(nil, nil, nil) }
            self.class4 = class4
            
            guard let class5 = Requirement(type: RequirementType.class5, currentTotal: 0, total: 0, progress: 0, complete: false, user: user!) else { return completion(nil, nil, nil) }
            self.class5 = class5
            
            guard let pano = Requirement(type: RequirementType.pano, currentTotal: 0, total: 0, progress: 0, complete: false, user: user!) else { return completion(nil, nil, nil) }
            self.pano = pano
            
            guard let bwx = Requirement(type: RequirementType.bwx, currentTotal: 0, total: 0, progress: 0, complete: false, user: user!) else { return completion(nil, nil, nil) }
            self.bwx = bwx
            
            guard let pa = Requirement(type: RequirementType.pa, currentTotal: 0, total: 0, progress: 0, complete: false, user: user!) else { return completion(nil, nil, nil) }
            self.pa = pa
            
            guard let injection = Requirement(type: RequirementType.injection, currentTotal: 0, total: 0, progress: 0, complete: false, user: user!) else { return completion(nil, nil, nil) }
            self.injections = injection
            
            allRequirements = [class1A, class1B, class2, class3, class4, class5, pano, bwx, pa, injection]
            allTrackedRequirements = [class1A, class1B, class2, class3, class5, pano, bwx, pa, injection]
            classRequirements = [class1A, class1B, class2, class3, class4, class5]
            Stack.sharedStack.save()
            self.allRequirements = allRequirements
            self.allTrackedRequirements = allTrackedRequirements
            self.classRequirements = classRequirements
            completion(allRequirements, allTrackedRequirements, classRequirements)
        } else {
            let allRequirements = contextCards().allRequirements
            let allTrackedRequirements = contextCards().allTrackedRequirements
            let classRequirements = contextCards().classRequirements
            completion(allRequirements, allTrackedRequirements, classRequirements)
        }
    }
    
    private func contextCards() -> (allRequirements: [Requirement], allTrackedRequirements: [Requirement], classRequirements: [Requirement]) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Requirement")
        let context = Stack.sharedStack.managedObjectContext
        
        var allRequirements: [Requirement] = []
        var allTrackedRequirements: [Requirement] = []
        var classRequirements: [Requirement] = []
        
        do {
            allRequirements = try context.fetch(request) as! [Requirement]
        } catch let error {
            print(error.localizedDescription)
        }
        
        for requirement in allRequirements {
            switch requirement.type {
            case RequirementType.class1A.rawValue:
                self.class1A = requirement
                classRequirements.append(requirement)
                allTrackedRequirements.append(requirement)
                break
            case RequirementType.class1B.rawValue:
                self.class1B = requirement
                classRequirements.append(requirement)
                allTrackedRequirements.append(requirement)
                break
            case RequirementType.class2.rawValue:
                self.class2 = requirement
                classRequirements.append(requirement)
                allTrackedRequirements.append(requirement)
                break
            case RequirementType.class3.rawValue:
                self.class3 = requirement
                classRequirements.append(requirement)
                allTrackedRequirements.append(requirement)
                break
            case RequirementType.class4.rawValue:
                self.class4 = requirement
                classRequirements.append(requirement)
                break
            case RequirementType.class5.rawValue:
                self.class5 = requirement
                classRequirements.append(requirement)
                allTrackedRequirements.append(requirement)
                break
            case RequirementType.pano.rawValue:
                self.pano = requirement
                allTrackedRequirements.append(requirement)
                break
            case RequirementType.bwx.rawValue:
                self.bwx = requirement
                allTrackedRequirements.append(requirement)
                break
            case RequirementType.pa.rawValue:
                self.pa = requirement
                allTrackedRequirements.append(requirement)
                break
            case RequirementType.injection.rawValue:
                self.injections = requirement
                allTrackedRequirements.append(requirement)
                break
            default:
                break
            }
        }
        
        let orderedAllRequirements = allRequirements.sorted { $0.orderNumber < $1.orderNumber }
        let orderedAllTrackedRequirements = allTrackedRequirements.sorted { $0.orderNumber < $1.orderNumber }
        let orderedClassRequirements = classRequirements.sorted { $0.orderNumber < $1.orderNumber }
        
        return (allRequirements: orderedAllRequirements, allTrackedRequirements: orderedAllTrackedRequirements, classRequirements: orderedClassRequirements)
    }
    
    func updateRequirementTotal(newTotal: Int64, requirement: Requirement) {
        if requirement.type == self.class3.type || requirement.type == self.class4.type {
            class3.total = newTotal
            class4.total = newTotal
            Stack.sharedStack.save()
        } else {
            requirement.total = newTotal
            Stack.sharedStack.save()
        }
    }
    
    func updateRequirementCurrentTotal(newCurrentTotal: Int64, type: RequirementType) {
        switch type {
        case .class1A:
            self.class1A.currentTotal = newCurrentTotal
        case .class1B:
            self.class1B.currentTotal = newCurrentTotal
        case .class2:
            self.class2.currentTotal = newCurrentTotal
        case .class3:
            self.class3.currentTotal = newCurrentTotal
        case .class4:
            self.class4.currentTotal = newCurrentTotal
        case .class5:
            self.class5.currentTotal = newCurrentTotal
        case .defaultClass:
            break
        default:
            break
        }
        Stack.sharedStack.save()
    }
    
    func completeRequirement(requirement: Requirement) {
        requirement.complete = true
        Stack.sharedStack.save()
    }
}






