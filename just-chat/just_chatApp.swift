//
//  just_chatApp.swift
//  just-chat
//
//  Created by admin on 28.01.2021.
//

import SwiftUI

@main
struct just_chatApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
