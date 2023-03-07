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
      HStack {
        Image(systemName: "leaf.fill")
          .foregroundColor(.green)
        Text("SwiftUI Realm Test")
      }
      
      if let data = viewModel.members.value {
        ForEach(Array(data.enumerated()), id: \.offset) { _, member in
          Text(member.stageName)
        }
      }
    }
    .onAppear {
      viewModel.getMembers()
    }
  }
}
