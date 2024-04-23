//
//  TodoCreateViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/17/24.
//

import SwiftUI
import UIFeatureKit

@Reducer
public struct TodoCreateViewStore {
  
  @ObservableState
  public struct State: Equatable {
    public var todo: String
    public var targetDate: Date
    public var folder: Folder?
    @Presents public var folderPicker: FolderPickerViewStore.State?
    
    public init(todo: String, targetDate: Date, folder: Folder?) {
      self.todo = todo
      self.targetDate = targetDate
      self.folder = folder
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    
    case createTapped
    case folderTapped
    case closeTapped
    
    case folderPicker(PresentationAction<FolderPickerViewStore.Action>)
  }
  
  @Dependency(\.dismiss) private var dismiss
  @Dependency(\.todoDatabase) private var todoDatabase
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .createTapped:
        return createTapped(&state)
        
      case .folderTapped:
        state.folderPicker = .init(selectedFolder: state.folder)
        return .none
        
      case .closeTapped:
        return .run { _ in
          await dismiss()
        }
        
      case let .folderPicker(.presented(.delegate(.folderTapped(folder)))):
        state.folder = folder
        return .none
        
      case .folderPicker:
        return .none
      }
    }
    .ifLet(\.$folderPicker, action: \.folderPicker) {
      FolderPickerViewStore()
    }
  }
  
}

private extension TodoCreateViewStore {
  
  func createTapped(_ state: inout State) -> Effect<Action> {
    let todo = Todo(
      id: .init(),
      todo: state.todo,
      targetDate: state.targetDate,
      isComplete: false
    )
    
    if let folder = state.folder {
      todo.folder = folder
      folder.todos?.append(todo)
    }
    
    return .run { send in
      try todoDatabase.add(todo)
      await dismiss()
    }
  }
  
}
