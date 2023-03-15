//
//  AlbumAssembler.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 15/03/23.
//

import Foundation

protocol AlbumAssembler {
  func resolve() -> AlbumViewModel
  func resolve() -> AlbumUseCase
  func resolve() -> AlbumRepository
  func resolve() -> AlbumLocalDataSource
}

extension AlbumAssembler where Self: Assembler {
  func resolve() -> AlbumViewModel {
    return AlbumViewModel(albumUseCase: resolve())
  }
  
  func resolve() -> AlbumUseCase {
    return AlbumInteractor(repository: resolve())
  }
  
  func resolve() -> AlbumRepository {
    return DefaultAlbumRepository(albumDataSource: resolve())
  }
  
  func resolve() -> AlbumLocalDataSource {
    return DefaultAlbumLocalDataSource(provider: resolve())
  }
}
