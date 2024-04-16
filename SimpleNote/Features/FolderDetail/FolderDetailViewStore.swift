//
//  FolderDetailViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct FolderDetailViewStore {
  
  @ObservableState
  struct State: Equatable {
    var folder: Folder
    
    init(folder: Folder) {
      self.folder = folder
    }
  }
  
  enum Action {
    
  }
  
  @Dependency(\.dismiss) var dismiss
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      return .none
    }
  }
  
}
