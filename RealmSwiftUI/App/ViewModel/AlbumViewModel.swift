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
  
  @Published var isAdded: Bool = false
  @Published var albums: ViewState<[Album]> = .initiate
  
  private let albumUseCase: AlbumUseCase
  private var cancellables = Set<AnyCancellable>()
  
  init(albumUseCase: AlbumUseCase) {
    self.albumUseCase = albumUseCase
  }
  
  func getAlbum() {
    albumUseCase.getAlbum()
      .receive(on: DispatchQueue.main)
      .sink { completion in
        switch completion {
        case .finished: ()
        case .failure(let error):
          self.albums = .error(error: error)
        }
      } receiveValue: { data in
        guard let data  = data else {
          self.albums = .error(error: NetworkError.requestError(message: "Data is nil"))
          return
        }
        self.albums = .success(data: data)
      }
      .store(in: &cancellables)
  }
  
  func loadAlbumJSONThenInsertRealmData() {
    albumUseCase.getAlbumJSON()
      .receive(on: DispatchQueue.main)
      .sink { completion in
        switch completion {
        case .finished: ()
        case .failure(let error):
          print(error.localizedDescription)
        }
      } receiveValue: { data in
        guard let data = data else { return }
        self.insertAlbumToRealmData(album: data)
      }
      .store(in: &cancellables)
  }
  
  private func insertAlbumToRealmData(album: [AlbumEntity]) {
    albumUseCase.addAlbum(data: album)
      .receive(on: DispatchQueue.main)
      .sink { completion in
        switch completion {
        case .finished: ()
        case .failure(let error):
          print(error.localizedDescription)
        }
      } receiveValue: { data in
        self.isAdded = data
      }
      .store(in: &cancellables)
  }
}
