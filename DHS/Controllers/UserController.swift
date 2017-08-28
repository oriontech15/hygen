//
//  UserController.swift
//  DHS
//
//  Created by Justin Smith on 6/13/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import CoreData

class UserController {
    
    static let shared = UserController()
    
    var currentUser: User? {
        get {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            let context = Stack.sharedStack.managedObjectContext
            
            var user: User!
            
            do {
                if let users = try context.fetch(request) as? [User] {
                    if users.count >= 1 {
                        user = users[0]
                    } else {
                        return nil
                    }
                } else {
                    return nil
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
            return user
        }
    }
    
    func createUser(name: String) -> User? {
        guard let user = User(name: name) else { return nil }
        Stack.sharedStack.save()
        return user
    }
    
    func updateColor(colorName: String) {
        self.currentUser?.colorName = colorName
        Stack.sharedStack.save()
    }
}
