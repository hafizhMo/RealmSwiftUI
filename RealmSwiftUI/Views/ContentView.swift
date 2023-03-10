//
//  ContentView.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
  
  @ObservedObject var viewModel: MemberViewModel
  
  var body: some View {
    VStack {
      if let data = viewModel.members.value, data.count != 0 {
        List {
          ForEach(data) { member in
            cell(member: member)
          }
        }
        
      } else {
        Text("Tap **+** to add new Items")
          .font(.caption)
          .foregroundColor(.gray)
      }
    }
    .onAppear {
      viewModel.loadMember()
    }
    .navigationTitle("Items")
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        HStack {
          addButton()
          deleteButton()
        }
      }
    }
  }
}

extension ContentView {
  func cell(member: Member) -> some View {
    NavigationLink {
      DetailView(member: member)
    } label: {
      VStack(alignment: .leading, spacing: 4) {
        Text(member.name)
        Text(member.zodiacSign)
          .font(.caption)
          .foregroundColor(.gray)
      }
    }
  }

  func addButton() -> some View {
    Button {
      viewModel.uploadMember()
    } label: {
      Image(systemName: "plus")
    }
  }
  
  func deleteButton() -> some View {
    Button {
      viewModel.removeMember()
    } label: {
      Image(systemName: "trash")
    }
  }
}
