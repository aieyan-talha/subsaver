//
//  TotalMoneyView.swift
//  SubSaver
//
//  Created by Winnie on 14/5/2023.
//

import SwiftUI

struct TotalMoneyView: View {
    
    @Binding var showMoney: Float
    
    @Binding var dateType: DateType
    
    private var dateTypeString: String {
        switch dateType {
        case .week:
            return "week"
        case .month:
            return "month"
        case .year:
            return "year"
        }
    }
    
    var didClickBackBlock: (()->Void)?
    
    var body: some View {
        VStack {
            /*
             Text("Total/\(dateTypeString)")
             .font(.system(size: 50))
             .foregroundColor(.white)
             .multilineTextAlignment(.center)
             
             Text(String(format: "$%.0.2f",
             showMoney))
             .font(.system(size: 50))
             .foregroundColor(.white)
             .multilineTextAlignment(.center)
             */
            
            HStack(){
                Button(action: {
                    didClickBackBlock?()
                }) {
                    Image("goback").resizable()
                }.frame(width: 60, height: 40)
                Spacer()
            }.padding()
            .frame(height: 150)
            
        }
    }
    
}
