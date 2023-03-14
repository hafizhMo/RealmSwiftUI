//
//  Album.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 14/03/23.
//

import RealmSwift

class AlbumEntity: Object, Album, ObjectKeyIdentifiable, Codable {
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var title: String
  @Persisted var releaseYear: String
  @Persisted var _songs: List<SongEntity>
  var songs: [Song] {
    _songs.map()
  }

  enum CodingKeys: String, CodingKey {
    case title = "title"
    case releaseYear = "release_year"
    case _songs = "songs"
  }
}

protocol Album {
  var title: String { get }
  var releaseYear: String { get }
  var songs: [Song] { get }
}

class SongEntity: Object, Song, ObjectKeyIdentifiable, Codable {
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var title: String
  @Persisted var duration: String
  
  enum CodingKeys: String, CodingKey {
    case title
    case duration
  }
}

protocol Song {
  var title: String { get }
  var duration: String { get }
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
