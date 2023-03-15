//
//  AlbumEntity.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 15/03/23.
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
