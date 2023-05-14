//
//  FilterContentView.swift
//  SubSaver
//
//  Created by Winnie on 14/5/2023.
//

import SwiftUI

struct FilterContentView: View {
    
    @Binding var showMoney: Float
    
    @State var dateTypeString: String = "Week"
    
    @Binding var dateType: DateType {
        didSet {
            switch dateType {
            case .week:
                dateTypeString = "Week"
            case .month:
                dateTypeString = "Month"
            case .year:
                dateTypeString = "Year"
            }
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        RadialGradient.pageBackgroundRadialGradient
            .overlay(
                VStack(spacing: -10) {
                    WelcomeToptView(titleName: "Options",
                                    showAddButton: false)
                    Spacer()
                    TotalMoneyView(showMoney: $showMoney,
                                   dateType: $dateType) {
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    OptionsView(dateString: $dateTypeString) { selectDate in
                        print("Click：\(selectDate)")
                        dateType = selectDate
//                        showMoney = showMoney + 10
//                        switch dateType {
//                        case .week:
//                            showMoney = showMoney + 10
//                        case .month:
//                            showMoney = showMoney + 100
//                        case .year:
//                            showMoney = showMoney + 500
//                        }
                    }.offset(y:-10) //distance
            })
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
    }
}


