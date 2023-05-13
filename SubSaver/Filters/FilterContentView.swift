//
//  FilterContentView.swift
//  SubSaver
//
//  Created by Winnie on 13/5/2023.
//

import SwiftUI

struct FilterContentView: View {
    
    var body: some View {
        
        Color.RGBA(127, 189, 208)
            .overlay(
                VStack(spacing: -10) {
                    WelcomeToptView(titleName: "Filtering\n Subscriptitions",
                                    showAddButton: false)
                    Spacer()
                    TotalMoneyView()
                    Spacer()
                    OptionsView()
                        .offset(y:-10)
            })
            .ignoresSafeArea()
    }
}

struct FilterContentView_Previews: PreviewProvider {
    static var previews: some View {
        FilterContentView()
    }
}

