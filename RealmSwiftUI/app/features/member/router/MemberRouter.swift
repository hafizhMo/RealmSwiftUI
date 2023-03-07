//
//  MemberRouter.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import SwiftUI

struct MemberRouter {
  
  private let assembler: Assembler
  
  init(assembler: Assembler) {
    self.assembler = assembler
  }
  
  func routeMember() -> some View {
    return MemberScreen(viewModel: assembler.resolve())
  }
}
