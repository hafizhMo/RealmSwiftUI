//
//  MemberUseCase.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 15/03/23.
//

import Combine

protocol MemberUseCase {
  func getMember() -> AnyPublisher<[Member]?, Error>
  func getMemberJSON() -> AnyPublisher<[MemberEntity]?, Error>
  func addMember(data: [MemberEntity]) -> AnyPublisher<Bool, Error>
}

class MemberInteractor: MemberUseCase {

  private let repository: MemberRepository

  init(repository: MemberRepository) {
    self.repository = repository
  }

  func getMember() -> AnyPublisher<[Member]?, Error> {
    return repository.getMember()
  }

  func getMemberJSON() -> AnyPublisher<[MemberEntity]?, Error> {
    return repository.getMemberJSON()
  }

  func addMember(data: [MemberEntity]) -> AnyPublisher<Bool, Error> {
    return repository.addMember(data: data)
  }
}
