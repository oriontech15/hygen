//
//  User+CoreDataProperties.swift
//  DHS
//
//  Created by Justin Smith on 6/13/17.
//  Copyright © 2017 com.example. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var colorName: String?
    @NSManaged public var patients: NSSet?
    @NSManaged public var requirements: NSSet?

}

// MARK: Generated accessors for patients
extension User {

    @objc(addPatientsObject:)
    @NSManaged public func addToPatients(_ value: Patient)

    @objc(removePatientsObject:)
    @NSManaged public func removeFromPatients(_ value: Patient)

    @objc(addPatients:)
    @NSManaged public func addToPatients(_ values: NSSet)

    @objc(removePatients:)
    @NSManaged public func removeFromPatients(_ values: NSSet)

}

// MARK: Generated accessors for requirements
extension User {

    @objc(addRequirementsObject:)
    @NSManaged public func addToRequirements(_ value: Requirement)

    @objc(removeRequirementsObject:)
    @NSManaged public func removeFromRequirements(_ value: Requirement)

    @objc(addRequirements:)
    @NSManaged public func addToRequirements(_ values: NSSet)

    @objc(removeRequirements:)
    @NSManaged public func removeFromRequirements(_ values: NSSet)

}
