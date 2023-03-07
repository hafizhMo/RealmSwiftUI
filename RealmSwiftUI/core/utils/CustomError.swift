//
//  CustomError.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import Foundation

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
