//
//  ContentView.swift
//  SubSaver
//
//  Created by Aieyan Talha on 6/5/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, Sub Saver Creators!")
            Text("Lets Begin!")
            SmallCard(title: "this is an example", textContent: "this is an example content, feel free to make edits to the card in ./CardView")
            TimeAndDateNotificationExample()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TimeAndDateNotificationExample: View {
    
    @State private var selectedTime = Date()
    
    var body: some View {
        VStack {
            DatePicker("", selection: $selectedTime, displayedComponents: [.hourAndMinute])
                .labelsHidden()
            Button("Click to apply notification to ping on this date/time") {
                createNotification("Notification!", "THIS IS A TEST", selectedTime)
                
            }
        }
    }
}
