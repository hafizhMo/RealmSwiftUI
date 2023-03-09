//
//  Member.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 09/03/23.
//

import RealmSwift

class Member: Object, ObjectKeyIdentifiable {
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var name: String
  @Persisted var zodiacSign: String
  
  convenience init(name: String, zodiacSign: String) {
    self.init()
    self.name = name
    self.zodiacSign = zodiacSign
  }
}
