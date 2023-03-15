//
//  LoadingView.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 10/03/23.
//

import SwiftUI

struct LoadingScreen: View {

  @ObservedObject var viewModel: MemberViewModel
  let router: MainRouter

  @State private var willMoveToNextScreen = false
  @State private var downloadAmount = 0.0
  private let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()

  var body: some View {
    VStack() {
      LoadingView(text: "Member", isDone: $viewModel.isAdded) { onFinished in
        willMoveToNextScreen = onFinished
      }
    }
    .padding()
    .navigationDestination(isPresented: $willMoveToNextScreen, destination: {
      router.routeContent()
    })
    .onAppear {
      viewModel.loadMemberJSONThenInsertRealmData()
    }
  }
}

struct LoadingView: View {

  var text: String
  @Binding var isDone: Bool
  var onFinished: ((Bool) -> Void)

  @State private var downloadAmount = 0.0
  @State private var statusText: String = "Preparing "
  private let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
  
  var body: some View {
    VStack(spacing: 8) {
      
      HStack {
        Text(statusText + text)
        Spacer()
        
        ProgressView()
          .progressViewStyle(.circular)
          .tint(.accentColor)
          .opacity(isDone ? 0 : 1)
        
        if isDone {
          Image(systemName: "checkmark")
            .foregroundColor(.accentColor)
            .onAppear {
              statusText = "Fetching "
            }
        }
      }
      
      ProgressView(value: downloadAmount, total: 100)
        .onReceive(timer) { _ in
          if downloadAmount < 100 {
            downloadAmount += 1
          }
          
          if downloadAmount == 100 {
            onFinished(true)
          }
        }
      
    }
    .padding()
  }
}
