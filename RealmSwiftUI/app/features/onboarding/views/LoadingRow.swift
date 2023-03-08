//
//  LoadingRow.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 08/03/23.
//

import SwiftUI

struct LoadingRow: View {
  var text: String = ""
  @Binding var isDone: Bool
  @State private var downloadAmount = 0.0
  private let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
  
  var body: some View {
    VStack(spacing: 20) {
      HStack {
        Text(text)
        Spacer()
        ProgressView()
          .progressViewStyle(.circular)
          .tint(.accentColor)
          .opacity(isDone ? 0 : 1)
        
        if isDone {
          Image(systemName: "checkmark")
            .foregroundColor(.accentColor)
        }
      }
      
      ProgressView(value: downloadAmount, total: 100)
        .onReceive(timer) { _ in
          if downloadAmount < 100 {
            downloadAmount += 1
          }
        }
      
    }
    .padding()
  }
  
}
