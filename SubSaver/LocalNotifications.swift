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

func updateTriggerTime(time: Date) {
    let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
    
        let calendar = Calendar.current
        updateNotificationTime(hour: calendar.component(.hour, from: time), minute: calendar.component(.minute, from: time))
}
    
func updateNotificationTime(hour: Int, minute: Int) {
    // Get the shared instance of UNUserNotificationCenter
    let center = UNUserNotificationCenter.current()

    // Step 1: Retrieve the existing notifications
    center.getPendingNotificationRequests { notificationRequests in
        // Step 2: Iterate over the notifications and create new triggers
        let updatedRequests = notificationRequests.map { request -> UNNotificationRequest in
            // Get the original trigger
            guard let trigger = request.trigger as? UNCalendarNotificationTrigger else {
                return request
            }

            // Create a new date components with the updated time
            var updatedDateComponents = trigger.dateComponents
            updatedDateComponents.hour = hour
            updatedDateComponents.minute = minute

            // Create a new trigger with the updated time
            let updatedTrigger = UNCalendarNotificationTrigger(dateMatching: updatedDateComponents, repeats: trigger.repeats)

            // Create a new notification request with the updated trigger and other properties
            print(request.identifier)
            return UNNotificationRequest(identifier: request.identifier, content: request.content, trigger: updatedTrigger)
        }

        // Step 4: Remove the existing notifications
        let identifiers = notificationRequests.map { $0.identifier }
        center.removePendingNotificationRequests(withIdentifiers: identifiers)

        // Step 5: Add the new notification requests
        for request in updatedRequests {
            center.add(request) { error in
                if let error = error {
                    print("Error updating notification: \(error.localizedDescription)")
                } else {
                    print("Notification updated successfully.")
                }
            }
        }
    }
}


func createNotification(id:UUID, name:String, subDate:Date, period:String, price:Float) {
    // remove old notification of same id
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
    
    let interval:Interval = Interval(rawValue: period ) ?? .weekly;
    let content = UNMutableNotificationContent()
    
    var dateComponents:DateComponents;
    switch interval {
    case .weekly:
        dateComponents = Calendar.current.dateComponents([.weekday], from: subDate)
    case .monthly:
        dateComponents = Calendar.current.dateComponents([.day], from: subDate)
    case .annually:
        dateComponents = Calendar.current.dateComponents([.day, .month], from: subDate)
    }
    dateComponents.hour = 6;
    dateComponents.minute = 0;
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    let textContent:String = "Your next $\(price) payment for \(name) is today"
    content.title = "SubSaver Subscription";
    content.subtitle = textContent;
    content.sound = UNNotificationSound.default
    // Cancel the original notification request
    
    // Create a new notification request with updated content or trigger
    let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request)
}

func createNotification_old(_ title:String, _ message:String, _ notifTime:Date ) {
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

