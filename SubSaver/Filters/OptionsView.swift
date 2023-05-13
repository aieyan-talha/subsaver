//
//  OptionsView.swift
//  SubSaver
//
//  Created by Winnie on 13/5/2023.
//

import SwiftUI

struct OptionsView: View {
    var body: some View {
        let backgroundGradient = LinearGradient(
            gradient: Gradient(colors: [Color(red: 0.282, green: 0.184, blue: 0.969).opacity(0.75),
                                        Color(red: 0.176, green: 0.424, blue: 0.875).opacity(0.65)]),
            startPoint: .leading, endPoint: .trailing)
        ZStack{
            Rectangle()
                .frame(width: .screenWidth - 10)
                .cornerRadius(30)
                .foregroundStyle(backgroundGradient)
            
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
                    Text("four Disneye subscri pton renews on 29th July 2023")
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
                        
                    }) {
                        Text("Week").font(.system(size: 18))
                    }.frame(width: 100, height: 35,
                            alignment: .center)
                    .background(Color.RGBA(0, 0, 197))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button(action: {
                        
                    }) {
                        Text("Month").font(.system(size: 18))
                    }.frame(width: 100, height: 35,
                            alignment: .center)
                        .background(Color.RGBA(0, 0, 197))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                    Button(action: {
                        
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

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView()
    }
}
