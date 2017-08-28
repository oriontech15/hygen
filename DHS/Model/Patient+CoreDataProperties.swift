//
//  Patient+CoreDataProperties.swift
//  DHS
//
//  Created by Justin Smith on 8/16/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import CoreData


extension Patient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Patient> {
        return NSFetchRequest<Patient>(entityName: "Patient")
    }

    @NSManaged public var bwx: Bool
    @NSManaged public var bwxSets: Int16
    @NSManaged public var cbct: Bool
    @NSManaged public var dateOfAppointment: NSDate
    @NSManaged public var firstName: String
    @NSManaged public var injections: Int32
    @NSManaged public var injectionsOn: Bool
    @NSManaged public var lastName: String
    @NSManaged public var notes: String?
    @NSManaged public var pa: Bool
    @NSManaged public var panoXRay: Bool
    @NSManaged public var paNumber: Int64
    @NSManaged public var quads: Int64
    @NSManaged public var requirementComplete: Bool
    @NSManaged public var scanX: Bool
    @NSManaged public var schick: Bool
    @NSManaged public var xrays: Bool
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var complete: Bool
    @NSManaged public var requirement: Requirement
    @NSManaged public var user: User

}
