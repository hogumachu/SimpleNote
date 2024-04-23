//
//  FolderPickerViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import Foundation
import UIFeatureKit

@Reducer
public struct FolderPickerViewStore {
  
  @ObservableState
  public struct State: Equatable {
    public var selectedFolder: Folder?
    
    public init(selectedFolder: Folder? = nil) {
      self.selectedFolder = selectedFolder
    }
  }
  
  public enum Action {
    case closeTapped
    case folderTapped(Folder)
    case delegate(Delegate)
    
    public enum Delegate {
      case folderTapped(Folder)
    }
  }
  
  @Dependency(\.dismiss) private var dismiss
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
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
