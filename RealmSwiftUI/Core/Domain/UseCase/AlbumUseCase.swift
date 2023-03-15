//
//  AlbumUseCase.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 15/03/23.
//

import Combine

protocol AlbumUseCase {
  func getAlbum() -> AnyPublisher<[Album]?, Error>
  func getAlbumJSON() -> AnyPublisher<[AlbumEntity]?, Error>
  func addAlbum(data: [AlbumEntity]) -> AnyPublisher<Bool, Error>
}

class AlbumInteractor: AlbumUseCase {
  
  private let repository: AlbumRepository
  
  init(repository: AlbumRepository) {
    self.repository = repository
  }
  
  func getAlbum() -> AnyPublisher<[Album]?, Error> {
    return repository.getAlbum()
  }
  
  func getAlbumJSON() -> AnyPublisher<[AlbumEntity]?, Error> {
    return repository.getAlbumJSON()
  }
  
  func addAlbum(data: [AlbumEntity]) -> AnyPublisher<Bool, Error> {
    return repository.addAlbum(data: data)
  }
}
