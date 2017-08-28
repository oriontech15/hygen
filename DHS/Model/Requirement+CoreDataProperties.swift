//
//  Requirement+CoreDataProperties.swift
//  DHS
//
//  Created by Justin Smith on 8/28/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import CoreData


extension Requirement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Requirement> {
        return NSFetchRequest<Requirement>(entityName: "Requirement")
    }

    @NSManaged public var complete: Bool
    @NSManaged public var currentTotal: Int64
    @NSManaged public var progress: Double
    @NSManaged public var total: Int64
    @NSManaged public var type: String
    @NSManaged public var orderNumber: Int64
    @NSManaged public var patients: NSSet?
    @NSManaged public var user: User

}

// MARK: Generated accessors for patients
extension Requirement {

    @objc(addPatientsObject:)
    @NSManaged public func addToPatients(_ value: Patient)

    @objc(removePatientsObject:)
    @NSManaged public func removeFromPatients(_ value: Patient)

    @objc(addPatients:)
    @NSManaged public func addToPatients(_ values: NSSet)

    @objc(removePatients:)
    @NSManaged public func removeFromPatients(_ values: NSSet)

}
