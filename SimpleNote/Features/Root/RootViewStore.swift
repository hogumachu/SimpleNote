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
  
  @ObservableState
  struct State: Equatable {
    var selectedTab: RootTab = .home
    var home: HomeStore.State = .init()
    var folder: FolderHomeViewStore.State = .init()
  }
  
  enum Action {
    case home(HomeStore.Action)
    case folder(FolderHomeViewStore.Action)
    
    case tabSelected(RootTab)
  }
  
  var body: some ReducerOf<Self> {
    Scope(state: \.home, action: \.home) {
      HomeStore()
    }
    Scope(state: \.folder, action: \.folder) {
      FolderHomeViewStore()
    }
    
    Reduce { state, action in
      switch action {
      case .home:
        return .none
      case .folder:
        return .none
        
      case let .tabSelected(selectedTab):
        state.selectedTab = selectedTab
        return .none
      }
    }
  }
  
}
