//
//  ContentView.swift
//  SubSaver
//
//  Created by Aieyan Talha on 6/5/2023.
//

import SwiftUI

let backgroundColorGradient = RadialGradient(
    gradient: Gradient(colors: [Color(red: 0.176, green: 0.424, blue: 0.875).opacity(1), Color.white.opacity(0)]),
    center: .center, startRadius: 0, endRadius: 500)
struct ContentView: View {
    @State var showCreateForm: Bool = false
    @State var totalPrice:Float = 52.00;
    //@State var someVal: Int = 0
    
    //@State var fieldName: String = ""
    
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(
        sortDescriptors: []
    ) var subs: FetchedResults<SubscriptionModel>
    
    func handleCreateButton() {
        showCreateForm.toggle()
    }
    
    var body: some View {
        ZStack {
            backgroundColorGradient.ignoresSafeArea()
            VStack {
                Button(action: handleCreateButton) {
                    Text("+").font(.custom("Cambria", size: 20))
                }.frame(width: 50, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(40)
                
                Text("Total/Weekly $\(String(format: "%.2f", totalPrice))")
                    .font(.system(size: 40)).foregroundColor(.white).frame(width: 240, height: 96).multilineTextAlignment(.center)
                ScrollView {
                    ForEach(subs, id: \.self) { sub in
                        SmallCard(title: sub.name ?? "", textContent: sub.notes ?? "", price: sub.price ?? 0).transition(.slide)
                            .animation(.easeInOut(duration: 0.4))
                            
                    }
                    
                    TimeAndDateNotificationExample()
                }
                
                
            }
            .padding()
        }.fullScreenCover(isPresented: $showCreateForm) {
            GeometryReader { geo in
                ZStack{
                    CreateAndEditCardView(showPopup: $showCreateForm)
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
