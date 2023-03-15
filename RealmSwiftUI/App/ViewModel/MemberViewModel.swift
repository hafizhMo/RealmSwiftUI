//
//  MemberViewModel.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 09/03/23.
//

import Combine
import UIKit
import RealmSwift

final class MemberViewModel: ObservableObject {

  @Published var isAdded: Bool = false
  @Published var members: ViewState<[Member]> = .initiate

  private let memberUseCase: MemberUseCase
  private var cancellables = Set<AnyCancellable>()

  init(memberUseCase: MemberUseCase) {
    self.memberUseCase = memberUseCase
  }

  func getMember() {
    memberUseCase.getMember()
      .receive(on: DispatchQueue.main)
      .sink { completion in
        switch completion {
        case .finished: ()
        case .failure(let error):
          self.members = .error(error: error)
        }
      } receiveValue: { data in
        guard let data  = data else {
          self.members = .error(error: NetworkError.requestError(message: "Data is nil"))
          return
        }
        self.members = .success(data: data)
      }
      .store(in: &cancellables)
  }

  func loadMemberJSONThenInsertRealmData() {
    memberUseCase.getMemberJSON()
      .receive(on: DispatchQueue.main)
      .sink { completion in
        switch completion {
        case .finished: ()
        case .failure(let error):
          print(error.localizedDescription)
        }
      } receiveValue: { data in
        guard let data = data else { return }
        self.insertMemberToRealmData(member: data)
      }
      .store(in: &cancellables)
  }

  private func insertMemberToRealmData(member: [MemberEntity]) {
    memberUseCase.addMember(data: member)
      .receive(on: DispatchQueue.main)
      .sink { completion in
        switch completion {
        case .finished: ()
        case .failure(let error):
          print(error.localizedDescription)
        }
      } receiveValue: { data in
        self.isAdded = data
      }
      .store(in: &cancellables)
  }
}
