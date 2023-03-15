//
//  Album.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 14/03/23.
//

import Foundation

protocol Album {
  var title: String { get }
  var releaseYear: String { get }
  var songs: [Song] { get }
}
