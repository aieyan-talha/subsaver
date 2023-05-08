//
//  LocalNotifications.swift
//  SubSaver
//
//  Created by Jeffery Kwan How on 6/5/2023.
//


import UserNotifications

struct NotifyTime {
    let year:Int;
    let month:Int;
    let day:Int;
    let hour:Int;
    let minute:Int;
    
    init(_ year:Int, _ month:Int, _ day:Int, _ hour: Int, _ munite: Int) {
        self.year = year;
        self.month = month;
        self.day = day;
        self.hour = hour;
        self.minute = munite;
    }
}

func createNotification(_ title:String, _ message:String, _ notifTime:Date ) {
    let content = UNMutableNotificationContent()
    content.title = title;
    content.subtitle = message;
    content.sound = UNNotificationSound.default
    let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: notifTime)
    // show this notification five seconds from now
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    
    // choose a random identifier
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    // add our notification request
    UNUserNotificationCenter.current().add(request)
}

//example

