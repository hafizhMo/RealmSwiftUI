//
//  MemberRow.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 08/03/23.
//

import SwiftUI

struct MemberRow: View {
  let member: Member
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(member.birthName)
        .font(.headline)
        .foregroundColor(.primary.opacity(0.7))
      
      Text(member.birthday)
        .font(.subheadline)
        .foregroundColor(.secondary)
      
    }
  }

}
