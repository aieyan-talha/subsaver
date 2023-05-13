//
//  WelcomeToptView.swift
//  SubSaver
//
//  Created by Winnie on 13/5/2023.
//

import UIKit
import SwiftUI


struct WelcomeToptView: View {
    
    var titleName: String = ""
    
    var showAddButton: Bool = true
    
    var didClickAddBlock: (()->Void)?
    
    var body: some View {
        
        ZStack{
            Rectangle().frame(width: .screenWidth, height: 150).foregroundStyle(.clear)
        }.overlay(ToptCard(name: titleName,
                           showAddButton: showAddButton) {
            didClickAddBlock?()
        },alignment: .top)
        
    }
}



extension WelcomeToptView {
    
    struct ToptCard: View {
        
        var name: String = ""
        var showAddButton: Bool = true
        
        var didClickAddBlock: (()->Void)?
        
        let backgroundGradient = LinearGradient(
            gradient: Gradient(colors: [Color(red: 0.282, green: 0.184, blue: 0.969).opacity(0.75),
                                        Color(red: 0.176, green: 0.424, blue: 0.875).opacity(0.65)]),
            startPoint: .leading, endPoint: .trailing)
        var body: some View {
            
            Rectangle().frame(width: .screenWidth, height: 150).cornerRadius(30)
                .foregroundStyle(backgroundGradient)
            
            HStack(spacing: 10) {
                Text(name)
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .offset(y: 10)
                Spacer()
                if showAddButton {
                    Button(action: {
                        didClickAddBlock?()
                    }) {
                        Text("+").font(.system(size: 50))
                    }.frame(width: 50,
                            height: 50,
                            alignment: .trailing)
                        .foregroundColor(.white)
                }
            }.padding().frame(width: .screenWidth)
        }
    }
}
