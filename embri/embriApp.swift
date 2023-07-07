//
//  embriApp.swift
//  embri
//
//  Created by Robert Lynch on 7/6/23.
//

import SwiftUI

@main
struct embriApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
