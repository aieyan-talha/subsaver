//
//  utils.swift
//  SubSaver
//
//  Created by Winnie on 13/5/2023.
//
//
import Foundation
func calCost(subscription:Subscription, period: String) -> Double{
    var result: Double = 0.0
    if (period == "weekly"){
        result = subscription.price
    }
    else if(period == "monthly"){
        result = subscription.price * 4
    }else{
        result = subscription.price * 4 * 12
    }
    return result
}

func calTotalCost(subscription: [Subscription], period: String) -> Double{
    var result: Double = 0.0
    for element in subscription{
        result += calCost(subscription: element, period: period)
    }
    return result
}
