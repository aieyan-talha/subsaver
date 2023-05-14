//
//  Calculations.swift
//  SubSaver
//
//  Created by Jeffery Kwan How on 14/5/2023.
//

import Foundation
import SwiftUI

func stringToInterval (_ period:String) -> Interval {
    return Interval(rawValue: period) ?? .weekly;
}

func convertSpending (currentInteval:Interval, convertedInterval:Interval, price: Float) -> Float {
    switch currentInteval {
        case .weekly:
        switch convertedInterval {
            case .weekly:
                return price;
            case.monthly:
                return price*4;
            case.annually:
                return price*52;
        }
        case .monthly:
            switch convertedInterval {
                case .weekly:
                    return price/4;
                case.monthly:
                    return price;
                case.annually:
                    return price*12;
            }
        case .annually:
            switch convertedInterval {
                case .weekly:
                    return price/52;
                case.monthly:
                    return price/12;
                case.annually:
                    return price;
            }
    }
}

func calculateSpending (subs:FetchedResults<SubscriptionModel>, withPeriod:Interval) -> Float {
    var total:Float = 0;
    
    subs.forEach() {
        sub in
        if let period = sub.period {
            let interval:Interval = stringToInterval(period);
            let price:Float = sub.price;
            let adjustedPrice = convertSpending(currentInteval: interval, convertedInterval: withPeriod, price: price);
            total = total + adjustedPrice;
        } else {
            // handle the case where period is nil
            print("period is nil")
        }
    }
    return total;
}



