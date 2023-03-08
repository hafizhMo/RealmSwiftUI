//
//  OnBoardingAssembler.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 08/03/23.
//

import Foundation

protocol OnBoardingAssembler {
  func resolve() -> OnBoardingRouter
  func resolve() -> LoadingViewModel
}

extension OnBoardingAssembler where Self: Assembler {
  func resolve() -> OnBoardingRouter {
    return OnBoardingRouter(assembler: self)
  }
  
  func resolve() -> LoadingViewModel {
    return LoadingViewModel(memberUseCase: resolve())
  }
}
