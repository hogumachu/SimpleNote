//
//  RootViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct RootViewStore: Reducer {
  
  struct State: Equatable {
    var tab: RootTab = .home
    var home: HomeStore.State? = .init()
  }
  
  enum Action: Equatable {
    case home(HomeStore.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .home:
        return .none
        
      }
    }
    .ifLet(\.home, action: /Action.home) {
      HomeStore()
    }
  }
  
}
