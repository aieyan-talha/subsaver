//
//  LocalMemory.swift
//  SubSaver
//
//  Created by Jeffery Kwan How on 6/5/2023.
//

import SwiftUI

struct ReoccuringPeriod: Codable, Hashable {
    var days:Int = 0;
    var months:Int = 0;
    var years:Int = 0;
    
    init(weeks:Int=0, days:Int=0, months:Int=0, years:Int=0) {
        self.days += (weeks * 7);
        self.days += days;
        self.months += months;
        self.years += years;
    }
    
    func inDays() -> Int {
        return (self.days) + (self.months*31) + (self.years*365);
    }
}

struct Subscription: Codable, Hashable {
    let name: String;
    let details: String;
    let reoccurPeriod:ReoccuringPeriod;
    let price: Double;
    
    func asString() -> String {
        return "name: \(self.name) details: \(self.details)"
    }
}

class ScoreStore {
    let key = "subscriptions"
    
    func addSubscription(name:String, details:String, reoccurPeriod:ReoccuringPeriod, price:Double) {
        let subscriptionEntry = Subscription(name: name, details: details, reoccurPeriod: reoccurPeriod, price: price);
        var subscriptions = [Subscription]()
        
        if let data = UserDefaults.standard.data(forKey: key),
           let savedSubscriptions = try? JSONDecoder().decode([Subscription].self, from: data) {
            subscriptions = savedSubscriptions
        }
        
        subscriptions.append(subscriptionEntry)
        let encodedSubscriptions = try? JSONEncoder().encode(subscriptions)
        UserDefaults.standard.set(encodedSubscriptions, forKey: key)
    }
    
    func getSubscriptions() -> [Subscription] {
        if let data = UserDefaults.standard.data(forKey: key),
           let savedSubscriptions = try? JSONDecoder().decode([Subscription].self, from: data) {
            return savedSubscriptions
        }
        
        return []
    }
}

