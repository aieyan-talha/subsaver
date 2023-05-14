//
//  OptionsView.swift
//  SubSaver
//
//  Created by Winnie on 14/5/2023.
//

import SwiftUI

enum DateType: NSInteger {
    case week
    case month
    case year
}

struct OptionsView: View {
    
    @Binding var dateString: String
    
    var didClickDataTypeBlock: ((DateType)->Void)?
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: .screenWidth - 10)
                .cornerRadius(30)
                .foregroundStyle(LinearGradient.pageBackgroundLinearGradient)
            
            VStack {
                HStack {
                    Text("Options")
                        .font(.system(size: 35))
                        .frame(width: 165,
                               height: 65)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                
                VStack(spacing: 20){
                    Text("Your subscriptions are currentlycalculated by per \(dateString).")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("You can choose what would you iike to see on your subscription in your filters")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Please select the options below.")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.frame(width: .screenWidth - 40)
                
                Spacer()
                
                VStack(spacing: 20){
                    
                    Button(action: {
                        didClickDataTypeBlock?(.week)
                    }) {
                        Text("Week").font(.system(size: 18))
                    }.frame(width: 100, height: 35,
                            alignment: .center)
                    .background(Color.RGBA(0, 0, 197))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button(action: {
                        didClickDataTypeBlock?(.month)
                    }) {
                        Text("Month").font(.system(size: 18))
                    }.frame(width: 100, height: 35,
                            alignment: .center)
                        .background(Color.RGBA(0, 0, 197))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                    Button(action: {
                        didClickDataTypeBlock?(.year)
                    }) {
                        Text("Year").font(.system(size: 18))
                    }.frame(width: 100, height: 35,
                            alignment: .center)
                    .background(Color.RGBA(0, 0, 197))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                Spacer()
            }
        }
    }
}


