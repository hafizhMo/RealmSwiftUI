//
//  DefaultMemberRepository.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 15/03/23.
//

import Combine

class DefaultMemberRepository: MemberRepository {

  private let memberDataSource: MemberLocalDataSource

  init(memberDataSource: MemberLocalDataSource) {
    self.memberDataSource = memberDataSource
  }

  func getMemberJSON() -> AnyPublisher<[MemberEntity]?, Error> {
    return memberDataSource.getMemberJSON()
      .map { $0 }
      .eraseToAnyPublisher()
  }

  func getMember() -> AnyPublisher<[Member]?, Error> {
    return memberDataSource.getMember()
      .map { $0 }
      .eraseToAnyPublisher()
  }

  func addMember(data: [MemberEntity]) -> AnyPublisher<Bool, Error> {
    return memberDataSource.addMember(data: data)
      .eraseToAnyPublisher()
  }
}
