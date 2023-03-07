//
//  DataProvider.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import Realm
import RealmSwift
import Combine
import UIKit

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
