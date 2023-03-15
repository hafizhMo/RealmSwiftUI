//
//  LoadingView.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 10/03/23.
//

import SwiftUI

struct LoadingScreen: View {

  @ObservedObject var memberViewModel: MemberViewModel
  @ObservedObject var albumViewModel: AlbumViewModel
  let router: MainRouter

  @State private var showAlbumLoading = false
  @State private var willMoveToNextScreen = false
  @State private var downloadAmount = 0.0
  private let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()

  var body: some View {
    VStack() {
      LoadingView(text: "Member", isDone: $memberViewModel.isAdded) { onFinished in
        showAlbumLoading = true
      }
      
      if showAlbumLoading {
        LoadingView(text: "Album", isDone: $albumViewModel.isAdded) { onFinished in
          willMoveToNextScreen = onFinished
        }.onAppear {
          albumViewModel.loadAlbumJSONThenInsertRealmData()
        }
      }
    }
    .padding()
    .navigationDestination(isPresented: $willMoveToNextScreen, destination: {
      router.routeContent()
    })
    .onAppear {
      memberViewModel.loadMemberJSONThenInsertRealmData()
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
