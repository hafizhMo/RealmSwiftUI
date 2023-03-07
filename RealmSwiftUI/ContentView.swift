//
//  ContentView.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
  @ObservedRealmObject var group: Group
  
  var body: some View {
    VStack {
      if group.items.count == 0 {
        Text("Tap **+** to add new Items")
          .font(.caption)
          .foregroundColor(.gray)
      } else {
        List {
          ForEach(group.items) { item in
            cell(item: item)
          }
          .onDelete(perform: $group.items.remove)
          .onMove(perform: $group.items.move)
        }
      }
    }
    .navigationTitle("Items")
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        HStack {
          addButton()
        }
      }
    }
  }
}

extension ContentView {
  func cell(item: Item) -> some View {
    NavigationLink {
      DetailView(item: item)
    } label: {
      Text(item.name)
    }
  }

  func addButton() -> some View {
    Button {
      $group.items.append(Item())
    } label: {
      Image(systemName: "plus")
    }

  }
}
