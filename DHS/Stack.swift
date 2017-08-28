//
//  Stack.swift
//  ClashRoyaleTest
//
//  Created by Justin Smith on 4/21/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation

import CoreData

class Stack {
    
    static let sharedStack = Stack()
    
    // TEACHING NOTE: - lazy variables do not initialize until the first time they are called
    lazy var managedObjectContext: NSManagedObjectContext = Stack.setUpMainContext()
    
    static func setUpMainContext() -> NSManagedObjectContext {
        // TEACHING NOTES: - merging all models from bundle
        let bundle = Bundle.main
        guard let model = NSManagedObjectModel.mergedModel(from: [bundle])
            else { fatalError("model not found") }
        // TEACHING NOTE: - initializing persistent store coordinator from model
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        try! persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil,
                                                           at: storeURL()! as URL, options: nil)
        // TEACHING NOTE: - initializing managed object context and assigning its persistent store coordinator
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }
    
    static func storeURL () -> NSURL? {
        let documentsDirectory: NSURL? = try? FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: true) as NSURL
        
        return documentsDirectory?.appendingPathComponent("db.sqlite") as NSURL?
    }
    
    func save() {
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
            print("SAVED!")
        } catch {
            print("Error saving \(error.localizedDescription)")
        }
    }
}
