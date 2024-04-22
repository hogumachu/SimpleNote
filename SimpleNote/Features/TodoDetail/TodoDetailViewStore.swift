//
//  TodoDetailViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import Foundation
import ThirdPartyKit

@Reducer
struct TodoDetailViewStore {
  
  @ObservableState
  struct State: Equatable {
    fileprivate var origin: Todo
    var todo: String
    var targetDate: Date
    var folder: Folder?
    @Presents var folderPicker: FolderPickerViewStore.State?
    
    init(todo: Todo) {
      self.origin = todo
      self.todo = todo.todo.orEmpty
      self.targetDate = todo.targetDate.orNow
      self.folder = todo.folder
    }
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    
    case closeTapped
    case deleteTapped
    case editTapped
    case folderTapped
    
    case folderPicker(PresentationAction<FolderPickerViewStore.Action>)
  }
  
  @Dependency(\.dismiss) private var dismiss
  @Dependency(\.todoDatabase) private var todoDatebase
  
  var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .closeTapped:
        return .run { send in
          await dismiss()
        }
        
      case .deleteTapped:
        return .run { [todo = state.origin] send in
          try todoDatebase.delete(todo)
          await dismiss()
        }
        
      case .editTapped:
        state.origin.todo = state.todo
        state.origin.targetDate = state.targetDate
        if state.origin.folder != state.folder {
          state.origin.folder?.todos?.removeAll(where: { $0 == state.origin })
          state.origin.folder = state.folder
          state.folder?.todos?.append(state.origin)
        }
        
        return .run { send in
          await dismiss()
        }
        
      case .folderTapped:
        state.folderPicker = .init(selectedFolder: state.folder)
        return .none
        
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
