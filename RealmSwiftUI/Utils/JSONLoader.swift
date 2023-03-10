//
//  JSONLoader.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 10/03/23.
//

import Combine
import Foundation

class JSONLoader<T: Codable> {
  
  func load(fileName: String? = nil) -> AnyPublisher<T?, Error> {
    
    return Future<T?, Error> { completion in
      
      let bundle = Bundle(for: JSONLoader.self)
      let filename: String
      
      if let name = fileName {
        filename = name
      } else {
        filename = String(describing: T.self)
      }
      
      guard let path = bundle.path(forResource: filename, ofType: "json"),
            let value = try? String(contentsOfFile: path) else {
        completion(.failure(NetworkError.invalidResponse))
        return
      }
      
      let jsonData = Data(value.utf8)
      let decoder = JSONDecoder()
      
      do {
        let codable = try decoder.decode(T.self, from: jsonData)
        completion(.success(codable))
      } catch {
        print(String(describing: error))
        completion(.failure(NetworkError.invalidResponse))
      }
      
    }.eraseToAnyPublisher()
  }
}
