//
//  User+CoreDataClass.swift
//  DHS
//
//  Created by Justin Smith on 6/13/17.
//  Copyright © 2017 com.example. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    
    convenience init?(name: String = "", context:NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: context) else { return nil }
        self.init(entity: entity, insertInto: context)
        
        self.name = name
    }
}
