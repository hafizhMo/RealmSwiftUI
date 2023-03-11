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
  @AppStorage(PrefsKey.lastRead.rawValue) var lastRead: Int = 0
  
  var body: some View {
    VStack {
      if let data = viewModel.members.value, data.count != 0 {
        List {
          ForEach(data) { member in
            CellView(member: member)
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
    .navigationTitle(String(lastRead))
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

struct CellView: View {
  var member: Member
  @AppStorage(PrefsKey.fontSize.rawValue) var fontSize: Int = 16
  
  var body: some View {
    Button {
      //      DetailView(member: member)
      //        .onAppear {
      PrefHelper.saveInt(key: .fontSize, value: 20)
      PrefHelper.saveInt(key: .lastRead, value: Int(member.id))
      //        }
    } label: {
      VStack(alignment: .leading, spacing: 4) {
        Text(member.name)
          .font(.system(size: CGFloat(fontSize)))
        Text(member.zodiacSign)
          .font(.caption)
          .foregroundColor(.gray)
      }
    }
  }
}

extension ContentView {
  
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
