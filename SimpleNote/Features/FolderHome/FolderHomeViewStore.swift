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
  
  @Reducer(state: .equatable)
  enum Path {
    case detail(FolderDetailViewStore)
  }
  
  @ObservableState
  struct State: Equatable {
    var path = StackState<Path.State>()
  }
  
  enum Action {
    case path(StackAction<Path.State, Path.Action>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .path(.element(id, .detail(detailAction))):
        state.path.append(.detail(FolderDetailViewStore.State()))
        return .none
        
      default:
        return .none
      }
    }
    .forEach(\.path, action: \.path)
  }
}
