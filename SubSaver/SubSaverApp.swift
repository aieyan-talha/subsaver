//
//  SubSaverApp.swift
//  SubSaver
//
//  Created by Aieyan Talha on 6/5/2023.
//

import SwiftUI

@main
struct SubSaverApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

