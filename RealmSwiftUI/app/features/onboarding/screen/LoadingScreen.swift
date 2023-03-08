//
//  LoadingScreen.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 08/03/23.
//

import SwiftUI

struct LoadingScreen: View {
  
  @ObservedObject var viewModel: LoadingViewModel
  
  let router: OnBoardingRouter
  
  @State private var isDoneQuran = false
  @State private var isDoneHadith = false
  @State private var isOpenMember = false
  @State private var downloadAmount = 0.0
  let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
  
  var body: some View {
    VStack {
      LoadingRow(text: "Preparing Group Data", isDone: $isDoneQuran)
      if isDoneQuran {
        LoadingRow(text: "Preparing Member Data", isDone: $isDoneHadith)
          .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
              isDoneHadith.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
              isOpenMember.toggle()
            }
          }
      }
    }
    .padding(.horizontal, 32)
    .navigationLink(destination: router.routeMember(), isActive: $isOpenMember)
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        isDoneQuran.toggle()
      }
    }
  }
}
