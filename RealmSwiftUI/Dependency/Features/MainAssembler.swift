//
//  MainAssembler.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 15/03/23.
//

import Foundation

protocol MainAssembler {
  func resolve() -> DataProvider
  func resolve() -> MainRouter
}

extension MainAssembler where Self: Assembler {
  func resolve() -> DataProvider {
    return DataProvider()
  }

  func resolve() -> MainRouter {
    return MainRouter(assembler: self)
  }
}
