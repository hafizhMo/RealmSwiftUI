//
//  MemberLocalDataSource.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 15/03/23.
//

import Combine
import RealmSwift

protocol MemberLocalDataSource {
  func getMemberJSON() -> AnyPublisher<[MemberEntity]?, Error>
  func getMember() -> AnyPublisher<[MemberEntity], Error>
  func addMember(data: [MemberEntity]) -> AnyPublisher<Bool, Error>
}

final class DefaultMemberLocalDataSource: MemberLocalDataSource {

  private let provider: DataProvider

  init(provider: DataProvider) {
    self.provider = provider
  }

  func getMemberJSON() -> AnyPublisher<[MemberEntity]?, Error> {
    JSONLoader<[MemberEntity]>().load(fileName: "member")
  }

  func getMember() -> AnyPublisher<[MemberEntity], Error> {
    provider.objects(MemberEntity.self)
      .eraseToAnyPublisher()
  }

  func addMember(data: [MemberEntity]) -> AnyPublisher<Bool, Error> {
    provider.add(data)
      .eraseToAnyPublisher()
  }
}
