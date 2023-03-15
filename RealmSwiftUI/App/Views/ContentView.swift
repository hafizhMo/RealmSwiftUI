//
//  ContentView.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
  
  @ObservedObject var memberViewModel: MemberViewModel
  @ObservedObject var albumViewModel: AlbumViewModel
  //  @AppStorage(PrefsKey.lastRead.rawValue) var lastRead: Int = PrefHelper.getLastRead()
  
  var body: some View {
    VStack {
      if let members = memberViewModel.members.value, members.count != 0, let albums = albumViewModel.albums.value, albums.count != 0 {
        List {
          ForEach(Array(members.enumerated()), id: \.offset) { _, member in
            CellView(member: member)
          }
          ForEach(Array(albums.enumerated()), id: \.offset) { _, album in
            CellView(album: album)
          }
        }
        
      } else {
        Text("Tap **+** to add new Items")
          .font(.caption)
          .foregroundColor(.gray)
      }
    }
    .onAppear {
      memberViewModel.getMember()
      albumViewModel.getAlbum()
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
  var member: Member? = nil
  var album: Album? = nil
  @AppStorage(PrefsKey.fontSize.rawValue) var fontSize: Double = PrefHelper.getFontSize()
  
  var body: some View {
    Button {
      
    } label: {
      VStack(alignment: .leading, spacing: 4) {
        Text(member?.name ?? album?.title ?? "")
          .font(.system(size: fontSize))
        Text(member?.zodiacSign ?? album?.releaseYear ?? "")
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
