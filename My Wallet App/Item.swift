//
//  Item.swift
//  My Wallet App
//
//  Created by Mohit Sengar on 28/10/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
