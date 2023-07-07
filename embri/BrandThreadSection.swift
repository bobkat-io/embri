//
//  BrandThreadSection.swift
//  embri
//
//  Created by Robert Lynch on 7/6/23.
//

import SwiftUI

struct BrandThreadSection: View {
  
  @Environment(\.isSearching) private var isSearching
  @Environment(\.dismissSearch) private var dismissSearch
  @Environment(\.managedObjectContext) private var viewContext
  
  let brand: ThreadBrand
  let threads: [Thread]
  let savedThreads: FetchedResults<SavedThread>
  
  @Binding var search: String
  
  var filteredThreads: [Thread] {
    if isSearching {
      if search.isEmpty {
        return threads
      } else {
        return threads.filter { thread in
          thread.id.contains(search.trimmingPrefix("0")) || thread.name.lowercased().contains(search.lowercased())
        }
      }
    } else {
      return threads.filter { thread in
        savedThreads.contains { item in
          item.brand == self.brand.rawValue && item.id == thread.id
        }
      }
    }
  }
  
  var body: some View {
    if !filteredThreads.isEmpty {
      Section {
        ForEach(filteredThreads) { thread in
          Button(action: { addItem(id: thread.id) }) {
            VStack(alignment: .leading) {
              Text(thread.name).font(.title)
              Text(thread.id).font(.footnote)
            }
          }
          .foregroundColor(.black)
          .listRowBackground(LinearGradient(
            gradient: Gradient(colors: [.white, thread.color]),
            startPoint: .leading,
            endPoint: .trailing
          ))
          .deleteDisabled(!search.isEmpty)
        }.onDelete(perform: delete)
      } header: {
        Text(self.brand.rawValue.capitalized)
      }
    }
  }
  
  private func addItem(id: String) {
    withAnimation {
      let item = SavedThread(context: viewContext)
      item.id = id
      item.brand = brand.rawValue
      
      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
      
      dismissSearch()
    }
  }
  
  private func delete(at offsets: IndexSet) {
    withAnimation {
      offsets.map { offset in
        savedThreads.first { item in
          item.brand == self.brand.rawValue && threads[offset].id == item.id
        }!
      }.forEach(viewContext.delete)
      
      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
}

//struct BrandThreadSection_Previews: PreviewProvider {
//    static var previews: some View {
//      BrandThreadSection(brand: .brother, threads: [], savedThreads: <#T##FetchedResults<SavedThread>#>, search: <#T##Binding<String>#>)
//    }
//}
