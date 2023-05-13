//
//  ContentView.swift
//  SubSaver
//
//  Created by Aieyan Talha on 6/5/2023.
//

import SwiftUI

struct ContentView: View {
    @State var showCreateForm: Bool = false
    @State var isEditingSubscription: Bool = false
    @State var editingSubscriptionId: String = ""
    
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(
        sortDescriptors: []
    ) var subs: FetchedResults<SubscriptionModel>
    
    func handleCreateButton() {
        showCreateForm.toggle()
    }
    
    func handleEditSubscription(id: UUID?) {
        if let subId = id {
            self.isEditingSubscription = true
            self.editingSubscriptionId = subId.uuidString
            self.showCreateForm.toggle()
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: handleCreateButton) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 15)
                }.frame(width: 50, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(40)
                
                ScrollView {
                    ForEach(subs, id: \.self) { sub in
                        SmallCard(title: sub.name ?? "", textContent: sub.notes ?? "", handleEdit: {
                            self.handleEditSubscription(id: sub.id)
                        })
                    }
                    
                    TimeAndDateNotificationExample()
                }
                
                
            }
            .padding()
        }.fullScreenCover(isPresented: $showCreateForm) {
            GeometryReader { geo in
                ZStack{
                    CreateAndEditCardView(showPopup: $showCreateForm, isEditingSubscription: $isEditingSubscription, editingSubscriptionId: $editingSubscriptionId)
                }.frame(height: geo.size.height)
                    .background(BackgroundBlurView())
                    
            }
        }
    }
}

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
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
