//
//  AlbumViewModel.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 14/03/23.
//

import Combine
import UIKit
import RealmSwift

final class AlbumViewModel: ObservableObject {
  
  @Published var isAdded: ViewState<Bool> = .initiate
  @Published var albums: ViewState<[Album]> = .initiate
  @Published var albumsEntity: ViewState<[AlbumEntity]> = .initiate
  
  private let provider = DataProvider()
  private var cancellables = Set<AnyCancellable>()
  
  func getAlbumJSON() -> AnyPublisher<[AlbumEntity]?, Error> {
    return JSONLoader<[AlbumEntity]>().load(fileName: "album")
      .eraseToAnyPublisher()
  }
  
  func uploadAlbumJSON() {
    let result = getAlbumJSON()
    result
      .receive(on: DispatchQueue.main)
      .sink { completion in
        switch completion {
        case .finished: ()
        case .failure(let error):
          self.albumsEntity = .error(error: error)
        }
      } receiveValue: { data in
        guard let data = data else { return }
        self.albumsEntity = .success(data: data)
        self.uploadAlbum(data)
      }
      .store(in: &cancellables)
    
  }
  
  // MARK: - Insert to Realm
  
  func addAlbum(_ value: [AlbumEntity]) -> AnyPublisher<Bool, Error> {
    return provider.add(value)
      .eraseToAnyPublisher()
  }
  
  func uploadAlbum(_ value: [AlbumEntity] = []) {
    addAlbum(value)
      .receive(on: DispatchQueue.main)
      .sink { completion in
        switch completion {
        case .finished:
          print("finished...")
        case .failure(let error):
          print("failure")
          self.isAdded = .error(error: error)
        }
      } receiveValue: { value in
        self.isAdded = .success(data: value)
        print("receiveValue...")
      }
      .store(in: &cancellables)
  }
  
  // MARK: - Get from Realm
  
  func getAlbum() -> AnyPublisher<[Album], Error> {
    provider.objects(AlbumEntity.self)
      .map { $0 }
      .eraseToAnyPublisher()
  }
  
  func loadAlbum() {
    getAlbum()
      .receive(on: DispatchQueue.main)
      .sink { completion in
        switch completion {
        case .finished: ()
        case .failure(let error):
          self.albums = .error(error: error)
        }
      } receiveValue: { value in
        self.albums = .success(data: value)
      }
      .store(in: &cancellables)
  }
}
