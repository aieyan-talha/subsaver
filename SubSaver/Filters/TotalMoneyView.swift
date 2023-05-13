//
//  TotalMoneyView.swift
//  SubSaver
//
//  Created by Winnie on 13/5/2023.
//

import SwiftUI

struct TotalMoneyView: View {
    var body: some View {
        VStack {
            
            Text("Total/Week")
                .font(.system(size: 50))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Text("$42.00")
                .font(.system(size: 50))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            HStack(){
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Refresh").font(.system(size: 30))
                }.frame(width: 120,
                        alignment: .center)
                    .foregroundColor(.white)
            }
            
        }.frame(height: 250)

    }
}

struct TotalMoneyView_Previews: PreviewProvider {
    static var previews: some View {
        TotalMoneyView()
    }
}
