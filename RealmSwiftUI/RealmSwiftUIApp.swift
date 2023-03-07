//
//  RealmSwiftUIApp.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import SwiftUI
import RealmSwift

let app: RealmSwift.App? = nil
@main
struct RealmSwiftUIApp: SwiftUI.App {
  @ObservedResults(Group.self) var groups
  var body: some Scene {
    WindowGroup {
      if let group = groups.first {
        NavigationView {
          ContentView(group: group)
        }
      } else {
        ProgressView()
          .onAppear {
            $groups.append(Group())
          }
      }
    }
  }
}
