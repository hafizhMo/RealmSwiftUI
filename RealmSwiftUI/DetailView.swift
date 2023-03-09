//
//  DetailView.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import SwiftUI
import RealmSwift

struct DetailView: View {
  @ObservedRealmObject var member: Member
  
  var body: some View {
    ScrollView {
      Text("Edit Name")
        .font(.caption)
        .foregroundColor(.gray)
      TextField("New Name", text: $member.name)
    }
    .padding()
    .navigationTitle(member.name)
  }
}
