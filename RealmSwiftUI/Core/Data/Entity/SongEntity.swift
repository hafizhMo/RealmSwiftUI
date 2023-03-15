//
//  SongEntity.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 15/03/23.
//

import RealmSwift

class SongEntity: Object, Song, Codable {
  @Persisted var title: String
  @Persisted var duration: String

  enum CodingKeys: String, CodingKey {
    case title
    case duration
  }
}

extension List where Element == SongEntity {
  func map() -> [Song] {
    var results = [Song]()
    for value in self {
      results.append(value)
    }
    return results
  }
}
