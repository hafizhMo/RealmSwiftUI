//
//  MemberRepository.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import Combine

class DefaultMemberRepository: MemberRepository {
  
  private let localDataSource: MemberLocalDataSource
  
  init(localDataSource: MemberLocalDataSource) {
    self.localDataSource = localDataSource
  }
  
  func getMembers() -> AnyPublisher<[Member]?, Error> {
    return localDataSource.getMemberJSON()
      .map { $0 }
      .eraseToAnyPublisher()
  }
  
}
