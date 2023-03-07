//
//  Item.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import RealmSwift

final class Item: Object, ObjectKeyIdentifiable {
  @Persisted(primaryKey: true) var _id: ObjectId
  @Persisted var name = "Name"
  @Persisted(originProperty: "items") var group: LinkingObjects<Group>
}
