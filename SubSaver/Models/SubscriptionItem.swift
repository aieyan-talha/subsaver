//
//  SubscriptionModel.swift
//  SubSaver
//
//  Created by Aieyan Talha on 11/5/2023.
//

import Foundation

class SubscriptionItem: NSObject, ObservableObject {
    var name: String
    var date: Date
    
    init(name: String, date: Date) {
        self.name = name
        self.date = date
    }
}
