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

//Given a Subscription Object (Definition in LocalMemory file) and a string (“year”, “month” or “week”). Calculate the cards cost for that time period.Return the value as a Double.

func calculateCost(for subscription: Subscription, period: String) -> Double {
    let days: Int
    
    switch period {
    case "year":
        days = 365 * subscription.reoccurPeriod.years
    case "month":
        days = 31 * subscription.reoccurPeriod.months
    case "week":
        days = 7 * subscription.reoccurPeriod.weeks
    default:
        days = 0
    }
    
    return subscription.price * Double(days)
}

//Given an array of subscriptions and a time period: String ('year', ‘month or ‘day’). Calculate the total cost of the subscription for that time period. Return a Double.

func calculateTotalCost(for subscriptions: [Subscription], period: String) -> Double {
    var totalCost = 0.0
    
    for subscription in subscriptions {
        totalCost += calculateCost(for: subscription, period: period)
    }
    
    return totalCost
}

