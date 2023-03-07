//
//  MemberScreen.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import SwiftUI

struct MemberScreen: View {
  
  @ObservedObject var viewModel: MemberViewModel
  
  var body: some View {
    VStack {
      if let data = viewModel.members.value {
        List {
          ForEach(Array(data.enumerated()), id: \.offset) { _, member in
            MemberRow(member: member)
          }
        }
      }
    }
    .onAppear {
      viewModel.getMembers()
    }
  }
}
