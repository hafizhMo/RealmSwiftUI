//
//  MemberUseCase.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import Combine

protocol MemberUseCase {
  func getMembers() -> AnyPublisher<[Member]?, Error>
  
}

class MemberInteractor: MemberUseCase {
  
  private let repository: MemberRepository
  
  init(repository: MemberRepository) {
    self.repository = repository
  }
  
  func getMembers() -> AnyPublisher<[Member]?, Error> {
    return repository.getMembers()
  }
}
