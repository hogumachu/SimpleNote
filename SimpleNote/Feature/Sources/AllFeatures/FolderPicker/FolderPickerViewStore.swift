//
//  FolderPickerViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import BaseFeature
import Foundation

@Reducer
struct FolderPickerViewStore {
  
  @ObservableState
  struct State: Equatable {
    var selectedFolder: Folder?
  }
  
  enum Action {
    case closeTapped
    case folderTapped(Folder)
    case delegate(Delegate)
    
    enum Delegate {
      case folderTapped(Folder)
    }
  }
  
  @Dependency(\.dismiss) private var dismiss
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .closeTapped:
        return .run { send in
          await dismiss()
        }
        
      case let .folderTapped(folder):
        return .run { send in
          await send(.delegate(.folderTapped(folder)))
          await dismiss()
        }
        
      case .delegate:
        return .none
      }
    }
  }
  
}
