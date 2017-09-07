//
//  Patient+CoreDataProperties.swift
//  DHS
//
//  Created by Justin Smith on 9/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import CoreData


extension Patient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Patient> {
        return NSFetchRequest<Patient>(entityName: "Patient")
    }

    @NSManaged public var complete: Bool
    @NSManaged public var dateOfAppointment: NSDate
    @NSManaged public var email: String?
    @NSManaged public var firstName: String
    @NSManaged public var injectionsOn: Bool
    @NSManaged public var lastName: String
    @NSManaged public var notes: String?
    @NSManaged public var phone: String?
    @NSManaged public var quads: Int64
    @NSManaged public var injections: Int32
    @NSManaged public var requirement: Requirement
    @NSManaged public var user: User
    @NSManaged public var xrays: NSSet?

}

// MARK: Generated accessors for xrays
extension Patient {

    @objc(addXraysObject:)
    @NSManaged public func addToXrays(_ value: Xray)

    @objc(removeXraysObject:)
    @NSManaged public func removeFromXrays(_ value: Xray)

    @objc(addXrays:)
    @NSManaged public func addToXrays(_ values: NSSet)

    @objc(removeXrays:)
    @NSManaged public func removeFromXrays(_ values: NSSet)

}
