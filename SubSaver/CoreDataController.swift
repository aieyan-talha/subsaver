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
    
    func editItem(item: SubscriptionModel, newName: String, newNotes: String, newDate: Date, newCurrencyType: String, newPrice: Float, newPeriod:Interval) {
        item.name = newName
        item.notes = newNotes
        item.price = newPrice
        item.selectedCurrency = newCurrencyType
        item.subDate = newDate
        item.period = newPeriod.rawValue
        
        let context = container.viewContext
        createNotification(id: item.id!, name: newName, subDate: newDate, period: newPeriod.rawValue, price: newPrice)
        do {
            try context.save()
        } catch let error as NSError {
            print("Error updating item: \(error)")
        }
    }
    
}
