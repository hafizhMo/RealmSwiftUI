//
//  Member.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import Foundation

protocol Member {
  var id: Int { get }
  var stageName: String { get }
  var birthName: String { get }
  var birthday: String { get }
  var positions: [String] { get }
  var zodiacSign: String { get }
  
}
