//
//  PrefHelper.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 11/03/23.
//

import Foundation

enum PrefsKey: String {
  case lastRead
  case isFirstOpenApp
  case fontSize
}

struct PrefHelper {
  static let pref = UserDefaults.standard
  
  static func saveInt(key: PrefsKey, value: Int) {
    pref.set(value, forKey: key.rawValue)
    commit()
  }
  
  static func getInt(key: PrefsKey) -> Int {
    return pref.integer(forKey: key.rawValue)
  }
  
  static func saveBool(key: PrefsKey, value: Bool) {
    pref.set(value, forKey: key.rawValue)
    commit()
  }
  
  static func getBool(key: PrefsKey) -> Bool {
    if pref.bool(forKey: key.rawValue) {
      return pref.bool(forKey: key.rawValue)
    }
    return false
  }
  
  static func commit() {
    pref.synchronize()
  }
  
  static func getLastRead() -> Int {
    let lastRead = getInt(key: .lastRead)
    return lastRead
  }
  
  static func getFontSize() -> Int {
    let fontSize = getInt(key: .fontSize)
    return fontSize == 0 ? 16 : fontSize
  }
  
  static func getIsFirstOpenApp() -> Bool {
    return !getBool(key: .isFirstOpenApp)
  }
}
