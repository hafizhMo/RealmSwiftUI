//
//  NavigationLinkModifier.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 08/03/23.
//

import SwiftUI

struct NavigationLinkModifier<Destination: View>: ViewModifier {
  
  let destination: Destination
  @Binding var isActive: Bool
  let isDetailLink: Bool
  
  init(destination: Destination, isActive: Binding<Bool>, isDetailLink: Bool) {
    self.destination = destination
    self._isActive = isActive
    self.isDetailLink = isDetailLink
  }
  
  func body(content: Content) -> some View {
    ZStack {
      content
      
      NavigationLink(destination: destination, isActive: $isActive) {
        EmptyView()
      }.isDetailLink(isDetailLink)
    }
  }
}

extension View {
  func navigationLink<Destination: View>(
    destination: Destination,
    isActive: Binding<Bool>,
    isDetailLink: Bool = true
  ) -> some View {
    self.modifier(NavigationLinkModifier(destination: destination, isActive: isActive, isDetailLink: isDetailLink))
  }
}
