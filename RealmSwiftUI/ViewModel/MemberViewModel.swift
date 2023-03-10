//
//  MemberViewModel.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 09/03/23.
//

import Realm
import RealmSwift
import Combine
import UIKit
import RealmSwift

final class MemberViewModel: ObservableObject {
  
  @Published var isAdded: ViewState<Bool> = .initiate
  @Published var isDeleted: ViewState<Bool> = .initiate
  @Published var members: ViewState<[Member]> = .initiate
  
  private let provider = DataProvider()
  private var cancellables = Set<AnyCancellable>()
  
  func addMember() -> AnyPublisher<Bool, Error> {
    let value = [
      Member(name: "Jeon So Yeon", zodiacSign: "Virgo"),
      Member(name: "Cho Mi Yeon", zodiacSign: "Aquarius"),
      Member(name: "Nicha Yontararak", zodiacSign: "Libra-Scorpio Cusp"),
      Member(name: "Song Yu Qi", zodiacSign: "Libra"),
      Member(name: "Yeh Shu Hua", zodiacSign: "Capricorn")
    ]
    return provider.add(value)
      .eraseToAnyPublisher()
  }
  
  func getMember() -> AnyPublisher<[Member], Error> {
    provider.objects(Member.self)
      .eraseToAnyPublisher()
  }
  
  func deleteMember() -> AnyPublisher<Bool, Error> {
    provider.objects(Member.self)
      .flatMap { self.provider.delete($0) }
      .eraseToAnyPublisher()
  }
  
  func uploadMember() {
    addMember()
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
      print("receiveValue...")
      self.isAdded = .success(data: value)
      if value {
        self.loadMember()
      }
    }
    .store(in: &cancellables)
  }
  
  func removeMember() {
    deleteMember()
      .receive(on: DispatchQueue.main)
      .sink { completion in
        switch completion {
        case .finished:
          print("finished...")
        case .failure(let error):
          print("failure...")
          self.isDeleted = .error(error: error)
        }
      } receiveValue: { value in
        self.isDeleted = .success(data: value)
        print("receiveValue...")
        if value {
          self.loadMember()
        }
      }
      .store(in: &cancellables)
  }
  
  func loadMember() {
    getMember()
      .receive(on: DispatchQueue.main)
      .sink { completion in
      switch completion {
      case .finished: ()
      case .failure(let error):
        self.members = .error(error: error)
      }
    } receiveValue: { value in
      self.members = .success(data: value)
    }
    .store(in: &cancellables)
  }
}

class DataProvider {
  func objects<T: Object>(_ type: T.Type, predicate: NSPredicate? = nil) -> AnyPublisher<[T], Error> {
    return Future<[T], Error> { completion in
      if !self.isRealmAccessible() {
        completion(.failure(DatabaseError.requestFailed))
        return
      }
      
      guard let realm = try? Realm() else { completion(.failure(DatabaseError.invalidInstance)); return }
      realm.refresh()
      
      let result = predicate == nil ? realm.objects(type) : realm.objects(type).filter(predicate!)
      completion(.success(result.compactMap { $0 }))
    }
    .eraseToAnyPublisher()
  }
  
  func object<T: Object>(_ type: T.Type, key: String) -> AnyPublisher<T?, Error> {
    return Future<T?, Error> { completion in
      if !self.isRealmAccessible() {
        completion(.failure(DatabaseError.requestFailed))
        return
      }
      
      guard let realm = try? Realm() else { completion(.failure(DatabaseError.invalidInstance)); return }
      realm.refresh()
      
      let result = realm.object(ofType: type, forPrimaryKey: key)
      completion(.success(result))
    }
    .eraseToAnyPublisher()
  }
  
  func object<T: Object>(_ type: T.Type, key: Int) -> AnyPublisher<T?, Error> {
    return Future<T?, Error> { completion in
      if !self.isRealmAccessible() {
        completion(.failure(DatabaseError.requestFailed))
        return
      }
      
      guard let realm = try? Realm() else { completion(.failure(DatabaseError.invalidInstance)); return }
      realm.refresh()
      
      let result = realm.object(ofType: type, forPrimaryKey: key)
      completion(.success(result))
    }
    .eraseToAnyPublisher()
  }
  
  func add<T: Object>(_ data: [T], update: Realm.UpdatePolicy = .all) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      guard let realm = try? Realm() else { completion(.failure(DatabaseError.invalidInstance)); return }
      realm.refresh()
      
      if realm.isInWriteTransaction {
        realm.add(data, update: update)
        completion(.success(true))
      } else {
        do {
          try realm.write {
            realm.add(data, update: update)
          }
          completion(.success(true))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      }
    }
    .eraseToAnyPublisher()
  }
  
  func add<T: Object>(_ data: T, update: Realm.UpdatePolicy = .modified) -> AnyPublisher<Bool, Error> {
    add([data], update: update).eraseToAnyPublisher()
  }
  
  func runTransaction(action: () -> Void) {
    if !isRealmAccessible() { return }
    
    if let realm = try? Realm() {
      realm.refresh()
      
      try? realm.write {
        action()
      }
    }
  }
  
  func delete<T: Object>(_ data: [T]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      guard let realm = try? Realm() else { completion(.failure(DatabaseError.invalidInstance)); return }
      realm.refresh()
      
      do {
        try realm.write { realm.delete(data) }
        completion(.success(true))
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }
    .eraseToAnyPublisher()
  }
  
  func delete<T: Object>(_ data: T) -> AnyPublisher<Bool, Error> {
    delete([data]).eraseToAnyPublisher()
  }
  
  func clearAllData() -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if !self.isRealmAccessible() {
        completion(.failure(DatabaseError.requestFailed))
        return
      }
      
      guard let realm = try? Realm() else { completion(.failure(DatabaseError.invalidInstance)); return }
      realm.refresh()
      
      do {
        try realm.write { realm.deleteAll() }
        completion(.success(true))
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }
    .eraseToAnyPublisher()
  }
}

extension DataProvider {
  func isRealmAccessible() -> Bool {
    do { _ = try Realm() } catch {
      print("Realm is not accessible")
      return false
    }
    return true
  }
  
  func configureRealm() {
    let config = RLMRealmConfiguration.default()
    config.deleteRealmIfMigrationNeeded = true
    RLMRealmConfiguration.setDefault(config)
  }
}

enum ViewState<T> {
  case initiate
  case loading
  case empty
  case error(error: Error)
  case success(data: T)
  
  var value: T? {
    get {
      if case .success(let data) = self {
        return data
      }
      return nil
    }
    
    set {
      if newValue is Bool {
        self = .success(data: newValue!)
      }
    }
  }
  
  var isLoading: Bool {
    get {
      if case .loading = self {
        return true
      }
      return false
    }
    set {
      if newValue {
        self = .loading
      }
    }
  }
  
  var error: Error {
    get {
      if case .error(let error) = self {
        return error
      }
      return NetworkError.noConnection
    }
    
    set {
      self = .error(error: newValue)
    }
  }
}

extension ViewState: Equatable {
  static func == (lhs: ViewState<T>, rhs: ViewState<T>) -> Bool {
    switch (lhs, rhs) {
    case (.initiate, .initiate), (.empty, .empty), (.success, .success), (.loading, .loading), (.error, .error):
      return true
    default:
      return false
    }
  }
}

enum NetworkError: LocalizedError, Equatable {
  case noConnection
  case invalidResponse
  case requestError(message: String? = nil)
  
  var errorDescription: String? {
    switch self {
    case .noConnection:
      return "No internet connection."
    case .requestError(let message):
      return message
    default:
      return "Something went wrong."
    }
  }
}

enum DatabaseError: LocalizedError {
  case invalidInstance
  case requestFailed
  
  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }
}
