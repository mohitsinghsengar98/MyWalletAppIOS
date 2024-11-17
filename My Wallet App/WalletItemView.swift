//
//  WalletItemView.swift
//  My Wallet App
//
//  Created by Mohit Sengar on 16/11/24.
//

import SwiftUI

struct WalletItemView: View {
    var walletData : WalletItem
    var body: some View {
        VStack(spacing: 8){
            
            Text("Amt. - \(walletData.currency) \(String(format: "%.2f", walletData.amount))").font(.title).bold()
            
            Text("Usage Desc. - \(walletData.usageDescription)").frame(maxWidth: .infinity)
            
            Text("Type - \(walletData.usageType)").frame(maxWidth: .infinity).foregroundColor(usageTypeColor())
            
            if !walletData.personData.isEmpty{
                if walletData.usageType.lowercased() == UsageType.lend.rawValue{
                    Text("To person - \(walletData.personData)").frame(maxWidth: .infinity)
                }else if walletData.usageType.lowercased() == UsageType.borrowed.rawValue{
                    Text("From person - \(walletData.personData)").frame(maxWidth: .infinity)
                }
            }
            
            HStack{
                
                Spacer()
                
                Text("By Date - \(walletData.timestamp)")
                    .padding(.trailing, 15)
                
            }.padding(.trailing, 15)
            
        }/*.background(Color.white).cornerRadius(8.0)*/.padding(EdgeInsets(.init(top: 5, leading: 10, bottom: 5, trailing: 10)))
    
    }
    
    func usageTypeColor() -> Color{
        switch(walletData.usageType.lowercased()){
        case UsageType.credit.rawValue,UsageType.borrowed.rawValue : return Color.green
        case UsageType.lend.rawValue,UsageType.debit.rawValue: return Color.red
        default : return Color.orange
        }
    }
}

enum UsageType:String,CodingKey{
    case credit = "credit"
    case debit = "debit"
    case lend = "lend"
    case borrowed = "borrowed"
}

extension Date{
    func dateToString() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy hh:mm:ss a"
        return formatter.string(from: date)
    }
}

#Preview {
    let walletData = WalletItem.init(timestamp: Date().dateToString(), usageType: "", usageDescription: "", amount: 1000.00, personData: "", currency: "$")
    WalletItemView(walletData: walletData)
}
