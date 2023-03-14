//
//  RealmSwiftUIApp.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import SwiftUI

@main
struct RealmSwiftUIApp: App {

  var body: some Scene {
    WindowGroup {
        NavigationStack {
          if PrefHelper.getIsFirstOpenApp() {
            LoadingView()
          } else {
            ContentView(viewModel: AlbumViewModel())
          }
        }
    }
  }
  
}
