//
//  MainAssembler.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import Foundation
import RealmSwift

protocol MainAssembler {
  func resolve() -> DataProvider
}

extension MainAssembler where Self: Assembler {
  func resolve() -> DataProvider {
    return DataProvider()
  }
}
