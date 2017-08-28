//
//  Requirement+CoreDataClass.swift
//  DHS
//
//  Created by Justin Smith on 8/28/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import CoreData

@objc(Requirement)
public class Requirement: NSManagedObject {

    convenience init?(type: RequirementType, currentTotal: Int = 0, total: Int = 0, progress: Double = 0.0, complete: Bool = false, user: User, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Requirement", in: context) else { return nil }
        self.init(entity: entity, insertInto: context)
        
        self.type = type.rawValue
        self.currentTotal = Int64(currentTotal)
        self.total = Int64(total)
        self.progress = progress
        self.complete = complete
        self.user = user
        
        switch self.type {
        case RequirementType.class1A.rawValue:
            self.orderNumber = 0
            break
        case RequirementType.class1B.rawValue:
            self.orderNumber = 1
            break
        case RequirementType.class2.rawValue:
            self.orderNumber = 2
            break
        case RequirementType.class3.rawValue:
            self.orderNumber = 3
            break
        case RequirementType.class4.rawValue:
            self.orderNumber = 4
            break
        case RequirementType.class5.rawValue:
            self.orderNumber = 5
            break
        case RequirementType.pano.rawValue:
            self.orderNumber = 6
            break
        case RequirementType.bwx.rawValue:
            self.orderNumber = 7
            break
        case RequirementType.pa.rawValue:
            self.orderNumber = 8
            break
        case RequirementType.injection.rawValue:
            self.orderNumber = 9
            break
        default:
            break
        }
    }
}
