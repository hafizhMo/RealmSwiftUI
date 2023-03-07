//
//  MemberAssembler.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import Foundation

protocol MemberAssembler {
  func resolve() -> MemberRouter
  func resolve() -> MemberViewModel
  func resolve() -> MemberUseCase
  func resolve() -> MemberRepository
  func resolve() -> MemberLocalDataSource
}

extension MemberAssembler where Self: Assembler {
  
  func resolve() -> MemberRouter {
    return MemberRouter(assembler: self)
  }
  
  func resolve() -> MemberViewModel {
    return MemberViewModel(memberUseCase: resolve())
  }
  
  func resolve() -> MemberUseCase {
    return MemberInteractor(repository: resolve())
  }
  
  func resolve() -> MemberRepository {
    return DefaultMemberRepository(localDataSource: resolve())
  }
  
  func resolve() -> MemberLocalDataSource {
    return DefaultMemberLocalDataSource(provider: resolve())
  }
}
