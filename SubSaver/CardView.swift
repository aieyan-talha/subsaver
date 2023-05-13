//
//  CardView.swift
//  SubSaver
//
//  Created by Jeffery Kwan How on 6/5/2023.
//

import SwiftUI
import UserNotifications


struct OuterCard: View {
    var body: some View {
        Rectangle().frame(width: 356, height: 220).cornerRadius(20).foregroundColor(Color.white)
    }
}

struct InnerSmallCard: View {
    let cardTitle:String;
    let textContent:String;
    let handleEdit: () -> Void
    
    let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0.282, green: 0.184, blue: 0.969).opacity(0.75), Color(red: 0.176, green: 0.424, blue: 0.875).opacity(0.65)]),
        startPoint: .leading, endPoint: .trailing)
    
    var body: some View {
        ZStack{
            Rectangle().frame(width: 336, height: 200).cornerRadius(20).foregroundStyle(backgroundGradient)
        }.overlay(TitleCard(cardTitle: cardTitle, handleEdit: handleEdit), alignment: .top).overlay(ContentCard(textContent:textContent), alignment: .bottom)
        
    }
}

struct TitleCard: View {
    let cardTitle:String;
    let handleEdit: () -> Void
    
    let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0.282, green: 0.184, blue: 0.969).opacity(0.75), Color(red: 0.176, green: 0.424, blue: 0.875).opacity(0.65)]),
        startPoint: .leading, endPoint: .trailing)
    
    var body: some View {
        ZStack{
            Rectangle().frame(width: 336, height: 64).cornerRadius(20, corners: [.topLeft, .topRight]).foregroundStyle(backgroundGradient)
            HStack(spacing: 10) {
                Rectangle().frame(width:52, height: 52).cornerRadius(2).foregroundColor(.blue)
                Text(cardTitle).font(.system(size: 24, weight: Font.Weight.bold)).foregroundColor(.white)
                Spacer()
                Button(action: {
                    handleEdit()
                }) {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.white)
                        .font(.title2)
                }
            }.padding().frame(width: 336, height: 64)
        }
    }
}

struct ContentCard: View {
    let textContent:String;
    var body: some View {
        VStack {
            Text(textContent).font(.system(size: 16)).foregroundColor(.white)
            Spacer()
        }.padding(4).frame(width:336, height: 200 - 64)
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

struct SmallCard: View {
    let title:String;
    let textContent:String;
    let handleEdit: () -> Void
    
    var body: some View {
        ZStack {
            OuterCard()
            InnerSmallCard(cardTitle: title, textContent: textContent, handleEdit: handleEdit)
        }
    }
}
