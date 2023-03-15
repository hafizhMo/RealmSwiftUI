//
//  MemberAssembler.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 15/03/23.
//

import Foundation

protocol MemberAssembler {
  func resolve() -> MemberViewModel
  func resolve() -> MemberUseCase
  func resolve() -> MemberRepository
  func resolve() -> MemberLocalDataSource
}

extension MemberAssembler where Self: Assembler {
  func resolve() -> MemberViewModel {
    return MemberViewModel(memberUseCase: resolve())
  }

  func resolve() -> MemberUseCase {
    return MemberInteractor(repository: resolve())
  }

  func resolve() -> MemberRepository {
    return DefaultMemberRepository(memberDataSource: resolve())
  }

  func resolve() -> MemberLocalDataSource {
    return DefaultMemberLocalDataSource(provider: resolve())
  }
}
