//
//  MemberViewModel.swift
//  RealmSwiftUI
//
//  Created by Hafizh Mo on 09/03/23.
//

import Combine
import UIKit
import RealmSwift

final class MemberViewModel: ObservableObject {
  
  @Published var isAdded: ViewState<Bool> = .initiate
  @Published var isDeleted: ViewState<Bool> = .initiate
  @Published var members: ViewState<[Member]> = .initiate
  @Published var membersEntity: ViewState<[Member]> = .initiate
  
  private let provider = DataProvider()
  private var cancellables = Set<AnyCancellable>()
  
  func addMember(_ value: [Member]) -> AnyPublisher<Bool, Error> {
    return provider.add(value)
      .eraseToAnyPublisher()
  }
  
  func getMember() -> AnyPublisher<[Member], Error> {
    provider.objects(Member.self)
      .eraseToAnyPublisher()
  }
  
  func deleteMember() -> AnyPublisher<Bool, Error> {
    provider.objects(Member.self)
      .flatMap { self.provider.delete($0) }
      .eraseToAnyPublisher()
  }
  
  func uploadMember(_ value: [Member] = []) {
    addMember(value)
      .receive(on: DispatchQueue.main)
      .sink { completion in
      switch completion {
      case .finished:
        print("finished...")
      case .failure(let error):
        print("failure")
        self.isAdded = .error(error: error)
      }
    } receiveValue: { value in
      print("receiveValue...")
      self.isAdded = .success(data: value)
      if value {
        self.loadMember()
      }
    }
    .store(in: &cancellables)
  }
  
  func removeMember() {
    deleteMember()
      .receive(on: DispatchQueue.main)
      .sink { completion in
        switch completion {
        case .finished:
          print("finished...")
        case .failure(let error):
          print("failure...")
          self.isDeleted = .error(error: error)
        }
      } receiveValue: { value in
        self.isDeleted = .success(data: value)
        print("receiveValue...")
        if value {
          self.loadMember()
        }
      }
      .store(in: &cancellables)
  }
  
  func loadMember() {
    getMember()
      .receive(on: DispatchQueue.main)
      .sink { completion in
      switch completion {
      case .finished: ()
      case .failure(let error):
        self.members = .error(error: error)
      }
    } receiveValue: { value in
      self.members = .success(data: value)
    }
    .store(in: &cancellables)
  }
  
  func getMemberJSON() -> AnyPublisher<[Member]?, Error> {
    return JSONLoader<[Member]>().load(fileName: "member")
      .map { $0 }
      .eraseToAnyPublisher()
  }
  
  func uploadMemberJSON() {
    let result = getMemberJSON()
    result
      .receive(on: DispatchQueue.main)
      .sink { completion in
        switch completion {
        case .finished: ()
        case .failure(let error):
          self.membersEntity = .error(error: error)
        }
      } receiveValue: { data in
        self.membersEntity = .success(data: data ?? [])
        guard let finalData = self.membersEntity.value, !finalData.isEmpty else { return }
        self.uploadMember(finalData)
      }
      .store(in: &cancellables)

  }
}
