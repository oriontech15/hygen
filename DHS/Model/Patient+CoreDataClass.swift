//
//  Patient+CoreDataClass.swift
//  DHS
//
//  Created by Justin Smith on 8/16/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import CoreData

@objc(Patient)
public class Patient: NSManagedObject {
    
    convenience init?(firstName: String, lastName: String, dateOfAppointment: Date, classType: Requirement, user: User, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Patient", in: context) else { return nil }
        self.init(entity: entity, insertInto: context)
        
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfAppointment = dateOfAppointment as NSDate
        self.requirement = classType
        self.user = user
        self.injections = 0
        self.injectionsOn = false
        self.quads = 0
        self.notes = ""
        self.complete = false
        self.email = nil
        self.phone = nil
    }
}
