//
//  AppStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct AppStore {
  
  enum State: Equatable {
    case root(RootViewStore.State)
    
    init() {
      self = .root(.init())
    }
  }
  
  enum Action {
    case root(RootViewStore.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      return .none
    }
    .ifCaseLet(\.root, action: \.root) {
      RootViewStore()
    }
  }
  
}
