//
//  MemberEntity.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 15/03/23.
//

import RealmSwift

class MemberEntity: Object, Member, ObjectKeyIdentifiable, Codable {
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var name: String
  @Persisted var zodiacSign: String
  
  convenience init(name: String, zodiacSign: String) {
    self.init()
    self.name = name
    self.zodiacSign = zodiacSign
  }
  
  enum CodingKeys: String, CodingKey {
    case name = "name"
    case zodiacSign = "zodiac_sign"
  }
}
