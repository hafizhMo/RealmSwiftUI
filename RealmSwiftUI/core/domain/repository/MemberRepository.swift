//
//  MemberRepository.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 07/03/23.
//

import Combine

protocol MemberRepository {
  func getMembers() -> AnyPublisher<[Member]?, Error>
  
}
