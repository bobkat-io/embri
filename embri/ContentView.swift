//
//  ContentView.swift
//  embri
//
//  Created by Robert Lynch on 7/6/23.
//

import SwiftUI
import CoreData



struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @State private var search: String = ""

  var body: some View {
    NavigationStack {
      ThreadList(search: $search)
        .navigationTitle("Embri")
        .searchable(text: $search, prompt: Text("Add New Thread"))
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environment(
        \.managedObjectContext,
         PersistenceController.shared.container.viewContext
      )
      .environmentObject(Floriani())
  }
}
