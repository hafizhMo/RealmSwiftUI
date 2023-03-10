//
//  LoadingView.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 10/03/23.
//

import SwiftUI

struct LoadingView: View {
  
  @ObservedObject var viewModel = MemberViewModel()
  @State private var willMoveToNextScreen = false
  @State private var downloadAmount = 0.0
  private let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
  
  var body: some View {
    VStack(spacing: 20) {
      HStack {
        Text("Uploading Member")
        Spacer()
        ProgressView()
          .progressViewStyle(.circular)
          .tint(.accentColor)
          .opacity(viewModel.isAdded.value ?? false ? 0 : 1)
        
        if viewModel.isAdded.value ?? false {
            Image(systemName: "checkmark")
              .foregroundColor(.accentColor)
        }
      }
      
      ProgressView(value: downloadAmount, total: 100)
        .onReceive(timer) { _ in
          if downloadAmount < 100 {
            downloadAmount += 1
          }
          
          if let status = viewModel.isAdded.value, status, downloadAmount == 100 {
            willMoveToNextScreen = true
          }
        }
      
    }
    .onAppear {
//      viewModel.uploadMember()
      viewModel.uploadMemberJSON()
    }
    .padding()
    .navigationDestination(isPresented: $willMoveToNextScreen, destination: {
      ContentView(viewModel: viewModel)
    })
  }
}
