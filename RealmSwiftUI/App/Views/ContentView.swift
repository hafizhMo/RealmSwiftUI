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
//  @AppStorage(PrefsKey.lastRead.rawValue) var lastRead: Int = PrefHelper.getLastRead()
  
  var body: some View {
    VStack {
      if let data = viewModel.members.value, data.count != 0 {
        List {
          ForEach(Array(data.enumerated()), id: \.offset) { _, member in
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
      viewModel.getMember()
    }
    .navigationTitle("Member")
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
  @AppStorage(PrefsKey.fontSize.rawValue) var fontSize: Double = PrefHelper.getFontSize()
  
  var body: some View {
    Button {
      let _ = print(member.name)
    } label: {
      VStack(alignment: .leading, spacing: 4) {
        Text(member.name)
          .font(.system(size: fontSize))
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
//      viewModel.uploadMember()
    } label: {
      Image(systemName: "plus")
    }
  }
  
  func deleteButton() -> some View {
    Button {
//      viewModel.removeMember()
    } label: {
      Image(systemName: "trash")
    }
  }
}
