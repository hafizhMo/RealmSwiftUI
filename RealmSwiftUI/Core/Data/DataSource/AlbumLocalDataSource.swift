//
//  AlbumLocalDataSource.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 15/03/23.
//

import Combine
import RealmSwift

protocol AlbumLocalDataSource {
  func getAlbumJSON() -> AnyPublisher<[AlbumEntity]?, Error>
  func getAlbum() -> AnyPublisher<[AlbumEntity], Error>
  func addAlbum(data: [AlbumEntity]) -> AnyPublisher<Bool, Error>
}

final class DefaultAlbumLocalDataSource: AlbumLocalDataSource {
  
  private let provider: DataProvider
  
  init(provider: DataProvider) {
    self.provider = provider
  }
  
  func getAlbumJSON() -> AnyPublisher<[AlbumEntity]?, Error> {
    JSONLoader<[AlbumEntity]>().load(fileName: "album")
  }
  
  func getAlbum() -> AnyPublisher<[AlbumEntity], Error> {
    provider.objects(AlbumEntity.self)
      .eraseToAnyPublisher()
  }
  
  func addAlbum(data: [AlbumEntity]) -> AnyPublisher<Bool, Error> {
    provider.add(data)
      .eraseToAnyPublisher()
  }
}
