//
//  My_Wallet_AppApp.swift
//  My Wallet App
//
//  Created by Mohit Sengar on 28/10/24.
//

import SwiftUI
import SwiftData

@main
struct My_Wallet_AppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
//            ContentView()
            LoginScreen()
        }
        .modelContainer(sharedModelContainer)
    }
}
