//
//  FolderHomeViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct FolderHomeViewStore: Reducer {
  
  @ObservableState
  struct State: Equatable {
    var path = StackState<FolderDetailViewStore.State>()
    var folders = [Folder]()
  }
  
  enum Action {
    case path(StackAction<FolderDetailViewStore.State, FolderDetailViewStore.Action>)
    case addButtonTapped
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .path:
        return .none
        
      case .addButtonTapped:
        return .none
      }
    }
    .forEach(\.path, action: \.path) {
      FolderDetailViewStore()
    }
  }
}
