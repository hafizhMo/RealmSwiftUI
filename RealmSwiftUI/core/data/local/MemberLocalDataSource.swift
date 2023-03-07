//
//  MemberLocalDataSource.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import Combine
import RealmSwift

protocol MemberLocalDataSource {
  func getMemberJSON() -> AnyPublisher<[MemberEntity]?, Error>
  func getMember() -> AnyPublisher<[MemberEntity], Error>
  func addMember(member: MemberEntity) -> AnyPublisher<Bool, Error>
  func addMembers(members: [MemberEntity]) -> AnyPublisher<Bool, Error>
  func removeMember() -> AnyPublisher<Bool, Error>
}

final class DefaultMemberLocalDataSource: MemberLocalDataSource {
  
  private let provider: DataProvider
  
  init(provider: DataProvider) {
    self.provider = provider
  }
  
  func getMemberJSON() -> AnyPublisher<[MemberEntity]?, Error> {
    let result = JSONLoader<[MemberEntity]>().load(fileName: "member")
    return result
  }
  
  func getMember() -> AnyPublisher<[MemberEntity], Error> {
    provider.objects(MemberEntity.self)
      .eraseToAnyPublisher()
  }
  
  func addMember(member: MemberEntity) -> AnyPublisher<Bool, Error> {
    provider.add(member)
      .eraseToAnyPublisher()
  }
  
  func addMembers(members: [MemberEntity]) -> AnyPublisher<Bool, Error> {
    provider.add(members)
      .eraseToAnyPublisher()
  }
  
  func removeMember() -> AnyPublisher<Bool, Error> {
    return provider.objects(MemberEntity.self)
      .flatMap { self.provider.delete($0) }
      .eraseToAnyPublisher()
  }
  
}
