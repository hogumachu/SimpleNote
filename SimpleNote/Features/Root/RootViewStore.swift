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
    var tabs: [RootTab] = [.home, .folder]
    var home: HomeStore.State? = .init()
    var folder: FolderHomeViewStore.State? = .init()
  }
  
  enum Action {
    case home(HomeStore.Action)
    case folder(FolderHomeViewStore.Action)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .home:
        return .none
      case .folder:
        return .none
      }
    }
    .ifLet(\.home, action: /Action.home) {
      HomeStore()
    }
    .ifLet(\.folder, action: /Action.folder) {
      FolderHomeViewStore()
    }
  }
  
}
