//
//  AlbumRepository.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 15/03/23.
//

import Combine

protocol AlbumRepository {
  func getAlbum() -> AnyPublisher<[Album]?, Error>
  func getAlbumJSON() -> AnyPublisher<[AlbumEntity]?, Error>
  func addAlbum(data: [AlbumEntity]) -> AnyPublisher<Bool, Error>
}
