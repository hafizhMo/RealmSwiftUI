//
//  OnBoardingRouter.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 08/03/23.
//

import SwiftUI

struct OnBoardingRouter {
  
  private let assembler: Assembler
  
  init(assembler: Assembler) {
    self.assembler = assembler
  }
  
  func routeLoading() -> some View {
    return LoadingScreen(viewModel: assembler.resolve(), router: assembler.resolve())
  }
  
  func routeMember() -> some View {
    return MemberScreen(viewModel: assembler.resolve())
  }
}
