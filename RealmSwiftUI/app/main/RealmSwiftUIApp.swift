//
//  RealmSwiftUIApp.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import SwiftUI

@main
struct RealmSwiftUIApp: App {
  private let assembler = AppAssembler()
  
  var body: some Scene {
    WindowGroup {
      NavigationView {
        LoadingScreen(viewModel: assembler.resolve(), router: assembler.resolve())
      }
    }
  }
}
