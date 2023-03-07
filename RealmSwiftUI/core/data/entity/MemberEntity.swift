//
//  MemberEntity.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import RealmSwift

@objcMembers class MemberEntity: Object, Member, Codable {
  var id: Int = 0
  var stageName: String = ""
  var birthName: String = ""
  var birthday: String = ""
  var _positions = List<String>()
  var positions: [String] {
    _positions.map()
  }
  var zodiacSign: String = ""
  
  enum CodingKeys: String, CodingKey {
    case id
    case stageName = "stage_name"
    case birthName = "birth_name"
    case birthday
    case _positions = "positions"
    case zodiacSign = "zodiac_sign"
  }
  
}

extension List where Element == String {
  func map() -> [String] {
    var results = [String]()
    for value in self {
      results.append(value)
    }
    return results
  }
}
