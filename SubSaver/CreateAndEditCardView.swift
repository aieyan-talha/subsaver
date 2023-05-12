//
//  CreateAndEditCardView.swift
//  SubSaver
//
//  Created by Aieyan Talha on 9/5/2023.
//

import Foundation
import SwiftUI
import CoreData

struct CreateAndEditCardView: View {
    @Binding var showPopup: Bool
    @State private var username: String = ""
    @State private var subDate = Date.now
    @State private var price: Float = 0
    @State private var notes: String = ""
    @State var currencySelected: String = "USD"
    
    let currencyOptions: [String] = ["USD", "AUD", "YEN"]
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    func handleSaveButton() {
        print("BUTTON PRESSED")
        showPopup.toggle()
        
        let subscription = SubscriptionModel(context: managedObjectContext)
        let randomId = UUID()
        
        subscription.id = randomId
        subscription.name = username
        subscription.subDate = subDate
        subscription.selectedCurrency = currencySelected
        subscription.price = price
        subscription.notes = notes
        
        CoreDataController.shared.save()
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Add Subsciption")
                    .font(.system(size: 20, weight: .bold))
                Spacer()
            }.padding()
                .background(.blue)
            HStack {
                Text("Information Details")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
            }.padding(.horizontal)
                .padding(.vertical, 5)
            
            BasicTextField(fieldName: $username, text: "Subscription Name", placeholder: "Name")
            DatePicker(selection: $subDate, displayedComponents: [.date]) {
                Text("Date")
            }.padding()
            
            HStack {
                Text("Price")
                Spacer()
            }.padding(.horizontal)
            HStack {
                Picker("Select an option", selection: $currencySelected) {
                    ForEach(currencyOptions, id: \.self) { currency in
                        Text(currency)
                    }
                }.pickerStyle(.menu)
                    .padding(.vertical, 8)
                    .font(.system(size: 24))
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.clear, lineWidth: 2)
                    )
                    .padding(.horizontal)
                NumericTextField(fieldName: $price, placeholder: "$").padding(.horizontal)
            }
            BasicTextEditor(fieldName: $notes, text: "Notes")
        
            Button(action: handleSaveButton) {
                Text("Save")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

            }.padding()
            
        }.background(.purple)
            .cornerRadius(10)
            .padding()
    }
}

struct BasicTextField: View {
    @Binding var fieldName: String
    @State var text: String
    @State var placeholder: String
    
    var body: some View {
        HStack {
            Text(text)
            Spacer()
        }.padding(.horizontal)
        TextField(placeholder, text: $fieldName)
            .padding(.horizontal)
            .textFieldStyle(.roundedBorder)
    }
}

struct BasicTextEditor: View {
    @Binding var fieldName: String
    @State var text: String
    
    var body: some View {
        HStack {
            Text(text)
            Spacer()
        }.padding(.horizontal)
        TextEditor(text: $fieldName)
            .frame(height: 100)
//            .background(.red)
//            .border(.black)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.clear, lineWidth: 2)
            )
            .padding(.horizontal)

    }
}

struct NumericTextField: View {
    @Binding var fieldName: Float
    @State var placeholder: String
    
    var body: some View {
        TextField(placeholder, value: $fieldName, formatter: NumberFormatter())
            .keyboardType(.decimalPad)
            .padding(10)
            .font(.system(size: 24))
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.clear, lineWidth: 2)
            )
    }
}

// TO BE REMOVED: Should be removed before final submission
//struct CreateAndEditCardView_Previews: PreviewProvider {
//    @State var someValue: Bool = true
//    static var previews: some View {
//        CreateAndEditCardView(showPopup: $someValue)
//    }
//}

struct Previews_CreateAndEditCardView_LibraryContent: LibraryContentProvider {
    var views: [LibraryItem] {
        LibraryItem(/*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/)
    }
}
