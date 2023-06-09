//
//  CreateAndEditCardView.swift
//  SubSaver
//
//  Created by Aieyan Talha on 9/5/2023.
//

import Foundation
import SwiftUI
import CoreData

let titleGradient = LinearGradient(
    gradient: Gradient(colors: [Color(red: 0.282, green: 0.184, blue: 0.969).opacity(0.75), Color(red: 0.176, green: 0.424, blue: 0.875).opacity(0.65)]),
    startPoint: .leading, endPoint: .trailing)

struct CreateAndEditCardView: View {
    @Binding var showPopup: Bool
    @Binding var isEditingSubscription: Bool
    @Binding var editingSubscriptionId: String

    
    @State private var username: String = ""
    @State private var subDate = Date.now
    @State private var price: Float = 0
    @State private var notes: String = ""
    @State private var period:Interval = .weekly;
    @State var currencySelected: String = "USD"
    
    @State var edtitingSubscriptionItem: SubscriptionModel? = nil
    
    @State var buttonText: String = "Save"
    @State var headerText: String = "Add Subscription"
    
   // let currencyOptions: [String] = ["USD", "AUD", "YEN"]
    
    
   
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: SubscriptionModel.entity(),
        sortDescriptors: []
    ) var subs: FetchedResults<SubscriptionModel>
    
    func handleSaveButton() {
        showPopup.toggle()
        
        if (isEditingSubscription) {
            CoreDataController.shared.editItem(item: edtitingSubscriptionItem!, newName: username, newNotes: notes, newDate: subDate, newCurrencyType: currencySelected, newPrice: price, newPeriod: period)
            
            isEditingSubscription.toggle()
            editingSubscriptionId = ""
        } else {
            let subscription = SubscriptionModel(context: managedObjectContext)
            let randomId = UUID()
            
            subscription.id = randomId
            subscription.name = username
            subscription.subDate = subDate
            subscription.selectedCurrency = currencySelected
            subscription.price = price
            subscription.period = period.rawValue;
            subscription.notes = notes
            
            CoreDataController.shared.save()
            createNotification(id: randomId, name: username, subDate: subDate, period: period.rawValue, price: price)
        }
    }
    
    func closeForm () {
        setDefaultValues()
        showPopup.toggle()
    }
    
    func submittable() -> Bool {
        return self.username.count > 0
    }
    
    func setDefaultValues() {
        self.buttonText = "Save"
        self.headerText = "Add Subscription"
        isEditingSubscription = false
        editingSubscriptionId = ""
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(headerText)
                    .font(.system(size: 20, weight: .bold)).foregroundColor(.white)
                Spacer()
                Button(action: closeForm) {
                    Image(systemName: "multiply")
                        .foregroundColor(.white)
                        .font(.title)
                }
            }.padding()
                .background(titleGradient)
            HStack {
                Text("Information Details")
                    .font(.system(size: 18, weight: .bold)).foregroundColor(.white)
                Spacer()
            }.padding(.horizontal)
                .padding(.vertical, 5)
            
            BasicTextField(fieldName: $username, text: "Subscription Name", placeholder: "Name")
            DatePicker(selection: $subDate, displayedComponents: [.date]) {
                Text("Date")
                    .foregroundColor(.white)
            }.padding()
            Picker("", selection: $period) {
                            ForEach(Interval.allCases, id: \.self) { interval in
                                Text(interval.rawValue.capitalized).tag(interval)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
            
            HStack {
                Text("Price")
                    .foregroundColor(.white)
                Spacer()
            }.padding(.horizontal)
            HStack {
                Text("$AUD")
                    .foregroundColor(.white)
                    .font(.system(size: 24))
                    .padding(.vertical, 8)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.clear, lineWidth: 2)
                    )
                    .padding(.horizontal)
                NumericTextField(fieldName: $price, placeholder: "").padding(.horizontal)
            }

            BasicTextEditor(fieldName: $notes, text: "Notes")
        
            Button(action: handleSaveButton) {
                Text(buttonText)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(submittable() ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    

            }.padding().disabled(!submittable())
            
        }.background(backgroundGradient)
            .cornerRadius(10)
            .padding()
            .onAppear {
                if (isEditingSubscription) {
                    self.buttonText = "Update"
                    self.headerText = "Edit Subscription"
                    
                    let filteredSubs = subs.filter { sub in
                        sub.id == UUID(uuidString: editingSubscriptionId)
                    }
                    
                    if filteredSubs.count > 0 {
                        let sub = filteredSubs[0]
                        
                        self.username = sub.name ?? ""
                        self.price = sub.price
                        self.notes = sub.notes ?? ""
                        self.subDate = sub.subDate!
                        self.period = Interval(rawValue: sub.period ?? "weekly") ?? .weekly
                        self.currencySelected = sub.selectedCurrency ?? ""
                        
                        self.edtitingSubscriptionItem = sub
                    }
                    
                } else {
                    self.buttonText = "Save"
                    self.headerText = "Add Subscription"
                }
            }.onTapGesture {
                // Dismiss the keyboard
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
}

struct BasicTextField: View {
    @Binding var fieldName: String
    @State var text: String
    @State var placeholder: String
    
    var body: some View {
        HStack {
            Text(text).foregroundColor(.white)
            Spacer()
        }.padding(.horizontal)
        TextField(placeholder, text: $fieldName).foregroundColor(.white).onTapGesture {
            // Dismiss the keyboard
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }.textFieldStyle(.roundedBorder).background(titleGradient).shadow(radius: 2).frame(width:300).cornerRadius(10)
    }
}

struct BasicTextEditor: View {
    @Binding var fieldName: String
    @State var text: String
    
    var body: some View {
        HStack {
            Text(text).foregroundColor(.white)
            Spacer()
        }.padding(.horizontal)
        TextEditor(text: $fieldName).scrollContentBackground(.hidden).background(titleGradient).foregroundColor(.white)
                .frame(height: 100).shadow(radius: 2)
                .cornerRadius(10)
                .onTapGesture {
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .padding(.horizontal)

    }
}
private var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.minimum = 0
        return formatter
    }

struct NumericTextField: View {
    @Binding var fieldName: Float
    @State var placeholder: String
    
    var body: some View {
        TextField(placeholder, value: $fieldName, formatter: decimalFormatter)
            .keyboardType(.decimalPad)
            .padding(10)
            .foregroundColor(.white)
            .font(.system(size: 24))
            .background(titleGradient)
            .cornerRadius(10)
            .shadow(radius: 2)
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
