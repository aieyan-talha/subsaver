//
//  CoreDataController.swift
//  SubSaver
//
//  Created by Aieyan Talha on 11/5/2023.
//

import Foundation
import CoreData

struct CoreDataController {
    static let shared = CoreDataController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        container = NSPersistentContainer(name: "SubModel")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
            }
        }
    }
    
}