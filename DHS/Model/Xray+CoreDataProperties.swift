//
//  Xray+CoreDataProperties.swift
//  DHS
//
//  Created by Justin Smith on 9/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import CoreData


extension Xray {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Xray> {
        return NSFetchRequest<Xray>(entityName: "Xray")
    }

    @NSManaged public var pano: Bool
    @NSManaged public var bwx: Bool
    @NSManaged public var pa: Bool
    @NSManaged public var cbct: Bool
    @NSManaged public var schick: Bool
    @NSManaged public var scanx: Bool
    @NSManaged public var paNumber: Int32
    @NSManaged public var sets: Int32
    @NSManaged public var patient: Patient?

}
