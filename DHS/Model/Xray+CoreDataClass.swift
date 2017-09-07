//
//  Xray+CoreDataClass.swift
//  DHS
//
//  Created by Justin Smith on 9/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import CoreData

@objc(Xray)
public class Xray: NSManagedObject {
    convenience init?(patient: Patient,
                      pano: Bool,
                      bwx: Bool,
                      pa: Bool,
                      cbct: Bool,
                      schick: Bool,
                      scanx: Bool,
                      paNumber: Int?,
                      sets: Int?,
                      context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Xray", in: context) else { return nil }
        self.init(entity: entity, insertInto: context)
        
        self.pano = pano
        self.bwx = bwx
        self.pa = pa
        self.cbct = cbct
        self.schick = schick
        self.scanx = scanx
        self.paNumber = Int32(paNumber ?? 0)
        self.sets = Int32(sets ?? 0)
    }
}
