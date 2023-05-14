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
    @State var showConfirmationDialog: Bool = false
    @State var deleteSubscriptionId: String = ""
    
    @State var searchText:String = "";
    @State var isEditingSubscription: Bool = false
    @State var editingSubscriptionId: String = ""
    @State var totalPrice:Float = 52.00;
    var results = 0;
    
    //winnie for filtersubscription function
    @State var isNavPushFilter = false
    @State var defaultSelect: DateType = .week
    
    private var dataTypeToInterval: Interval {
        switch defaultSelect {
        case .week:
            return .weekly
        case .month:
            return .monthly
        case .year:
            return .annually
        }
    }
    
    private var dateTypeString: String {
        switch defaultSelect {
        case .week:
            return "week"
        case .month:
            return "month"
        case .year:
            return "year"
        }
    }
    
    //Aieyan
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
    
    func handleDeleteClick(id: UUID?) {
        if let subId = id {
            self.deleteSubscriptionId = subId.uuidString
            showConfirmationDialog.toggle()
        }
    }
    
    func handleDeleteSubscription() {
        let filteredSubs = subs.filter { sub in
            sub.id == UUID(uuidString: deleteSubscriptionId)
        }
        
        CoreDataController.shared.deleteItem(item: filteredSubs[0])
        self.deleteSubscriptionId = ""
    }
    
    var body: some View {
        //winnie Filter Push
        NavigationView {
            ZStack {
                RadialGradient.pageBackgroundRadialGradient.ignoresSafeArea()
                VStack {
                    NavigationLink(isActive: $isNavPushFilter) {
                        FilterContentView(showMoney: $totalPrice,
                                          dateType: $defaultSelect)
                    } label: {}
                    
                    ZStack {
                        HStack {
                            TextField("Search", text: $searchText).padding().frame(width: 300, height: 24).font(.system(size: 16)).background(
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                            Spacer()
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.secondary)
                                    .padding(.trailing, 8)
                            }
                            .opacity(searchText.isEmpty ? 0 : 1)
                            .animation(.default)
                            .padding(.trailing, 8)
                        }
                    }.frame(width: 300, height: 24)
                    
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
                    
                    Text("Total/\(dateTypeString) $\(String(format: "%.2f", calculateSpending(subs: subs, withPeriod: dataTypeToInterval)))")
                        .font(.system(size: 40)).foregroundColor(.white).frame(width: 240, height: 96).multilineTextAlignment(.center)
                    //winnie Filter button
                    HStack {
                        Spacer()
                        Button(action: {
                            isNavPushFilter = true
                        }) {
                            Text("Click Filter").font(.system(size: 25))
                        }.frame(width: 120,
                                alignment: .center)
                            .foregroundColor(.white)
                    }
                    ScrollView {
                        ForEach(subs, id: \.self) { sub in
                            
                            if (searchText.count == 0 || sub.name!.lowercased().contains(searchText.lowercased())) {
                                SmallCard(title: sub.name ?? "", textContent: sub.notes ?? "", period: sub.period ?? "weekly", handleEdit: {
                                    self.handleEditSubscription(id: sub.id)
                                }, handleDelete: {
                                    self.handleDeleteClick(id: sub.id)
                                }, price: sub.price).transition(.slide)
                                    .animation(.easeInOut(duration: 0.4))
                            }
                        }
                        
                        
                    }
                }
                .padding()
                .confirmationDialog("Deleting Subscription", isPresented: $showConfirmationDialog, actions: {
                    Button("Delete", role: .destructive, action: handleDeleteSubscription)
                }, message: {
                    Text("This will delete the subscription from the list. Please note that this action cannot be undone")
                })
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
    
    
}
