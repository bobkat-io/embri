//
//  EmbriApp.swift
//  Embri
//
//  Created by Robert Lynch on 7/6/23.
//

import SwiftUI
import SwiftyJSON


@main
struct EmbriApp: App {
  let persistenceController = PersistenceController.shared
  let floriani = Floriani()
  let brother = Brother()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        .environmentObject(floriani)
        .environmentObject(brother)
    }
  }
}
