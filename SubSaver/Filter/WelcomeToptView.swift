//
//  WelcomeToptView.swift
//  SubSaver
//
//  Created by Winnie on 14/5/2023.
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
        
        var body: some View {
            
            Rectangle().frame(width: .screenWidth, height: 150).cornerRadius(30)
                .foregroundStyle(LinearGradient.pageBackgroundLinearGradient)
            
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

