//
//  DefaultAlbumRepository.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 15/03/23.
//

import Combine

class DefaultAlbumRepository: AlbumRepository {
  
  private let albumDataSource: AlbumLocalDataSource
  
  init(albumDataSource: AlbumLocalDataSource) {
    self.albumDataSource = albumDataSource
  }
  
  func getAlbumJSON() -> AnyPublisher<[AlbumEntity]?, Error> {
    return albumDataSource.getAlbumJSON()
      .map { $0 }
      .eraseToAnyPublisher()
  }
  
  func getAlbum() -> AnyPublisher<[Album]?, Error> {
    return albumDataSource.getAlbum()
      .map { $0 }
      .eraseToAnyPublisher()
  }
  
  func addAlbum(data: [AlbumEntity]) -> AnyPublisher<Bool, Error> {
    return albumDataSource.addAlbum(data: data)
      .eraseToAnyPublisher()
  }
}

