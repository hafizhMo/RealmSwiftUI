//
//  LoadingViewModl.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 08/03/23.
//

import Combine
import Foundation

class LoadingViewModel: ObservableObject {
  
  private let memberUseCase: MemberUseCase
  
  init(memberUseCase: MemberUseCase) {
    self.memberUseCase = memberUseCase
  }
  
  @Published var members: ViewState<[Member]> = .initiate
  private var cancellable = Set<AnyCancellable>()
  
  func getMembers() {
    memberUseCase.getMembers()
      .receive(on: DispatchQueue.main)
      .sink { completion in
        switch completion {
        case .finished: ()
        case .failure(let error):
          self.members = .error(error: error)
        }
      } receiveValue: { value in
        self.members = .success(data: value ?? [])
      }
      .store(in: &cancellable)
  }
  
}
