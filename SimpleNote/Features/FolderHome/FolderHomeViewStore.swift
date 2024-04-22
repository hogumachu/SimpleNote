//
//  FolderHomeViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import Entity
import Foundation
import ThirdPartyKit

@Reducer
struct FolderHomeViewStore: Reducer {
  
  @ObservableState
  struct State: Equatable {
    @Presents var folderCreate: FolderCreateViewStore.State?
    var path = StackState<FolderDetailViewStore.State>()
  }
  
  enum Action {
    case path(StackAction<FolderDetailViewStore.State, FolderDetailViewStore.Action>)
    case addButtonTapped
    case folderCreate(PresentationAction<FolderCreateViewStore.Action>)
  }
  
  @Dependency(\.folderDatabase) var database
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .path:
        return .none
        
      case .addButtonTapped:
        state.folderCreate = FolderCreateViewStore.State(title: "", hexColor: "F05138")
        return .none
        
      case let .folderCreate(.presented(.delegate(.create(folder)))):
        return .run { send in
          try database.add(folder)
        }
        
      case .folderCreate:
        return .none
      }
    }
    .ifLet(\.$folderCreate, action: \.folderCreate) {
      FolderCreateViewStore()
    }
    .forEach(\.path, action: \.path) {
      FolderDetailViewStore()
    }
  }
}
