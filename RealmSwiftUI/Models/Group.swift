//
//  Group.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import RealmSwift

final class Group: Object, ObjectKeyIdentifiable {
  @Persisted(primaryKey: true) var _id: ObjectId
  @Persisted var items = RealmSwift.List<Item>()
}
