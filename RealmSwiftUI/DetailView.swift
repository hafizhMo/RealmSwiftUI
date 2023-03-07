//
//  DetailView.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import SwiftUI
import RealmSwift

struct DetailView: View {
  @ObservedRealmObject var item: Item
  
  var body: some View {
    ScrollView {
      Text("Edit Name")
        .font(.caption)
        .foregroundColor(.gray)
      TextField("New Name", text: $item.name)
    }
    .padding()
    .navigationTitle(item.name)
  }
}
