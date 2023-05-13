//
//  CardView.swift
//  SubSaver
//
//  Created by Jeffery Kwan How on 6/5/2023.
//

import SwiftUI
import UserNotifications

let HEIGHT:CGFloat = 280;
let CLOSED_HEIGHT:CGFloat = 160;
let WIDTH:CGFloat = 376;
let backgroundGradient = LinearGradient(
    gradient: Gradient(colors: [Color(red: 0.282, green: 0.184, blue: 0.969).opacity(0.75), Color(red: 0.176, green: 0.424, blue: 0.875).opacity(0.65)]),
    startPoint: .leading, endPoint: .trailing)

struct OuterCard: View {
    var body: some View {
        Rectangle().frame(width: WIDTH, height: HEIGHT).cornerRadius(20).foregroundColor(Color.white)
    }
}

struct InnerSmallCard: View {
    let cardTitle:String;
    let textContent:String;
    let handleEdit: () -> Void
    let price:Float;
    
    @State var isOpen:Bool = false;
    
    let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0.282, green: 0.184, blue: 0.969).opacity(0.75), Color(red: 0.176, green: 0.424, blue: 0.875).opacity(0.65)]),
        startPoint: .leading, endPoint: .trailing)
    
    var body: some View {
        ZStack{
            Rectangle().frame(width: WIDTH, height: (!isOpen ? CLOSED_HEIGHT : HEIGHT)).cornerRadius(20).foregroundStyle(backgroundGradient)
        }.overlay(TitleCard(cardTitle: cardTitle, handleEdit: handleEdit, isOpen:$isOpen), alignment: .top).overlay(ContentCard(textContent:textContent, price: price, isOpen:$isOpen), alignment: .bottom).animation(.easeInOut, value: isOpen)
    }
}

struct TitleCard: View {
    let cardTitle:String;
    let handleEdit: () -> Void
    
    let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0.282, green: 0.184, blue: 0.969).opacity(0.75), Color(red: 0.176, green: 0.424, blue: 0.875).opacity(0.65)]),
        startPoint: .leading, endPoint: .trailing)

    @Binding var isOpen:Bool;
    
    
    var body: some View {
        ZStack{
            Rectangle().frame(width: WIDTH, height: 64).cornerRadius(20, corners: [.topLeft, .topRight]).foregroundStyle(backgroundGradient)
            HStack(spacing: 10) {
                Rectangle().frame(width:52, height: 52).cornerRadius(2).foregroundColor(.blue)
                Text(cardTitle).font(.system(size: 24, weight: Font.Weight.bold)).foregroundColor(.white)
                
                Spacer()
//<<<<<<< HEAD
//
//            }.padding().frame(width: 336, height: 64)
//=======
//
                Button(action: {
                    handleEdit()
                }) {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                Image("down-arrow").resizable().colorInvert().scaledToFit().frame(width:25, height:25)
                    .rotationEffect(.degrees(!isOpen ? 180 : 0)).transition(.slide).animation(.easeInOut, value: isOpen)
                
            }.padding().frame(width: WIDTH-20, height: 64)
        }.onTapGesture {
            isOpen = !isOpen;
        }
    }
}

struct ContentCard: View {
    let textContent:String;
    let price:Float;
    @Binding var isOpen:Bool;
    //WIDTH-20
    let initialWidth:CGFloat = 50;
    var body: some View {
        VStack {
            Text("Your next payment is on xxxxx").font(.system(size: 16)).foregroundColor(.white)
            if (!isOpen) {
                PriceCard(price:price, interval: .weekly)
            }
            Spacer()
            if (isOpen) {
                PriceCard(price:price, interval: .weekly)
                PriceCard(price:price*4, interval: .monthly)
                PriceCard(price:price*52, interval: .annually)
                Text(textContent).font(.system(size: 16)).foregroundColor(.white)
            }
        }.padding(4).frame(width:WIDTH-20, height: (!isOpen ? CLOSED_HEIGHT-64 : HEIGHT-64))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

enum Interval {
    case weekly
    case monthly
    case annually
}

struct PriceCard: View {
    var price:Float;
    var interval:Interval;
    let PRICEHEIGHT:CGFloat = 36;
    let PRICEWIDTH:CGFloat = 348;
    
    var body: some View {
        ZStack {
            Rectangle().frame(width: PRICEWIDTH, height: PRICEHEIGHT).cornerRadius(20).foregroundStyle(backgroundGradient)
            Text("Total \(intervalString(interval)): $\(String(format: "%.2f", price))").font(.system(size: 16)).foregroundColor(.white)
        }
        
    }
    
    func intervalString(_ period:Interval) -> String {
        switch period {
            case .weekly:
                return "Weekly"
            case .monthly:
                return "Monthly"
            case .annually:
                return "Annually"
            }
    }
}

struct SmallCard: View {
    let title:String;
    let textContent:String;
    
    let handleEdit: () -> Void
    let price:Float;
    
    var body: some View {
        ZStack {
            InnerSmallCard(cardTitle: title, textContent: textContent, handleEdit: handleEdit, price: price)
        }
    }
}
