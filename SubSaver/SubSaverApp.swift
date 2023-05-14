//
//  SubSaverApp.swift
//  SubSaver
//
//  Created by Aieyan Talha on 6/5/2023.
//

import SwiftUI

@main
struct SubSaverApp: App {
    let coreDataController = CoreDataController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, coreDataController.container.viewContext)
        }
    }
    
    init() {
        // Set the accent color
        UITextField.appearance().backgroundColor = .clear;
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

