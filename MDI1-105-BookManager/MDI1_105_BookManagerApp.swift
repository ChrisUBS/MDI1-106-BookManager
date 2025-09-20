//
//  MDI1_105_BookManagerApp.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 11/09/25.
//

import SwiftUI
import SwiftData

@main
struct MDI1_105_BookManagerApp: App {
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
