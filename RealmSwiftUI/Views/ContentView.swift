//
//  ContentView.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
  
  @ObservedObject var viewModel: AlbumViewModel
  @AppStorage(PrefsKey.lastRead.rawValue) var lastRead: Int = PrefHelper.getLastRead()
  
  var body: some View {
    VStack {
      if let data = viewModel.albums.value, data.count != 0 {
        List {
          ForEach(Array(data.enumerated()), id: \.offset) { _, album in
            CellView(member: album)
          }
        }
        
      } else {
        Text("Tap **+** to add new Items")
          .font(.caption)
          .foregroundColor(.gray)
      }
    }
    .onAppear {
      viewModel.loadAlbum()
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
  var member: Album
  @AppStorage(PrefsKey.fontSize.rawValue) var fontSize: Double = PrefHelper.getFontSize()
  
  var body: some View {
    Button {
      PrefHelper.saveDouble(key: .fontSize, value: 20)
//      PrefHelper.saveInt(key: .lastRead, value: Int(member.id))
    } label: {
      VStack(alignment: .leading, spacing: 4) {
        Text(member.title)
          .font(.system(size: fontSize))
        Text(member.releaseYear)
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
