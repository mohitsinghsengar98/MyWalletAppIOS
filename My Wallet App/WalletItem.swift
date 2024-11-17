//
//  Item.swift
//  My Wallet App
//
//  Created by Mohit Sengar on 28/10/24.
//

import Foundation
import SwiftData

//@Model
//final class Item {
//    var timestamp: Date
//    
//    init(timestamp: Date) {
//        self.timestamp = timestamp
//    }
//}

@Model
final class WalletItem {
    var id = UUID()
    var timestamp: String
    var usageType:String
    var usageDescription:String
    var amount:Double
    var currency:String
    var personData:String
    
    init(timestamp: String,usageType:String,usageDescription:String,amount:Double,personData:String,currency:String) {
        self.timestamp = timestamp
        self.amount = amount
        self.usageType = usageType
        self.usageDescription = usageDescription
        self.personData = personData
        self.currency = currency
    }
}

@Model
final class FinalWalletData{
    var id : UUID
    var totalMyMoney : Double
    var totalMoneyUsed : Double
    var totalMoneyMade : Double
    var totalMoneyLend : Double
    var totalOthersMoneyBorrowed : Double
    
    init(id: UUID = UUID(), totalMyMoney: Double, totalMoneyUsed: Double, totalMoneyMade: Double, totalMoneyLend: Double, totalOthersMoneyBorrowed: Double) {
        self.id = id
        self.totalMyMoney = totalMyMoney
        self.totalMoneyUsed = totalMoneyUsed
        self.totalMoneyMade = totalMoneyMade
        self.totalMoneyLend = totalMoneyLend
        self.totalOthersMoneyBorrowed = totalOthersMoneyBorrowed
    }
}
