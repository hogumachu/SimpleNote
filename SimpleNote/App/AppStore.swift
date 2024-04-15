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
    case home(HomeStore.State)
    
    init() {
      self = .home(.init())
    }
  }
  
  enum Action: Equatable {
    case home(HomeStore.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      return .none
    }
    .ifCaseLet(\.home, action: \.home) {
      HomeStore()
    }
  }
  
}
