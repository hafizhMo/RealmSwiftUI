//
//  MemberRepository.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 15/03/23.
//

import Combine

protocol MemberRepository {
  func getMember() -> AnyPublisher<[Member]?, Error>
  func getMemberJSON() -> AnyPublisher<[MemberEntity]?, Error>
  func addMember(data: [MemberEntity]) -> AnyPublisher<Bool, Error>
}
