//
//  ColorList.swift
//  embri
//
//  Created by Robert Lynch on 7/6/23.
//

import SwiftUI

struct ThreadList: View {
  @EnvironmentObject private var floriani: Floriani
  @EnvironmentObject private var brother: Brother

  @Environment(\.isSearching) private var isSearching
  
  @FetchRequest(
    sortDescriptors: [],
    animation: .default
  )
  private var savedThreads: FetchedResults<SavedThread>
  
  @Binding var search: String

  var body: some View {
    if savedThreads.isEmpty && !isSearching {
      Text("Add a thread above")
    } else {
      List {
        BrandThreadSection(
          brand: .floriani,
          threads: floriani.threads,
          savedThreads: savedThreads,
          search: $search
        )
        
        BrandThreadSection(
          brand: .brother,
          threads: brother.threads,
          savedThreads: savedThreads,
          search: $search
        )
      }
    }
  }
}

struct ThreadList_Previews: PreviewProvider {
  @State static var search: String = "";
  
  static var previews: some View {
    ThreadList(search: $search)
      .environment(
        \.managedObjectContext,
         PersistenceController.shared.container.viewContext
      )
      .environmentObject(Floriani())
  }
}
