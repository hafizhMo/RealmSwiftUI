//
//  LoadingRouter.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 15/03/23.
//

import SwiftUI

struct MainRouter {

  private let assembler: Assembler

  init(assembler: Assembler) {
    self.assembler = assembler
  }

  func routeContent() -> some View {
    ContentView(viewModel: assembler.resolve())
  }
}
