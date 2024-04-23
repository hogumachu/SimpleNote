//
//  FolderHomeViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import Foundation
import UIFeatureKit

@Reducer
public struct FolderHomeViewStore: Reducer {
  
  @ObservableState
  public struct State: Equatable {
    @Presents public var folderCreate: FolderCreateViewStore.State?
    public var path = StackState<FolderDetailViewStore.State>()
    
    public init(folderCreate: FolderCreateViewStore.State? = nil, path: StackState<FolderDetailViewStore.State> = StackState<FolderDetailViewStore.State>()) {
      self.folderCreate = folderCreate
      self.path = path
    }
  }
  
  public enum Action {
    case path(StackAction<FolderDetailViewStore.State, FolderDetailViewStore.Action>)
    case addButtonTapped
    case folderCreate(PresentationAction<FolderCreateViewStore.Action>)
  }
  
  @Dependency(\.folderDatabase) private var database
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
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
