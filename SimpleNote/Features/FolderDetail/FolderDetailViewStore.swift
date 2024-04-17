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
    @Presents var todoCreate: TodoCreateViewStore.State?
    var folder: Folder
    
    init(folder: Folder) {
      self.folder = folder
    }
  }
  
  enum Action {
    case closeTapped
    case editTapped
    case createTapped
    case checkTapped(Todo)
    case deleteTapped(Todo)
    case delegate(Delegate)
    case todoCreate(PresentationAction<TodoCreateViewStore.Action>)
    
    enum Delegate {
      case close
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  @Dependency(\.todoDatabase) var todoDatabase
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .closeTapped:
        return .run { send in
          await send(.delegate(.close))
        }
        
      case .editTapped:
        return .none
        
      case .createTapped:
        state.todoCreate = .init(todo: "", targetDate: .now)
        return .none
        
      case let .checkTapped(todo):
        todo.isComplete.toggle()
        return .none
        
      case let .deleteTapped(todo):
        do {
          state.folder.todos.removeAll(where: { $0 == todo })
          try todoDatabase.delete(todo)
        } catch {
          
        }
        return .none
        
      case .delegate:
        return .none
        
      case let .todoCreate(.presented(.delegate(.create(todo)))):
        todo.folder = state.folder
        state.folder.todos.append(todo)
        return .run { send in
          try todoDatabase.add(todo)
        }
        
      case .todoCreate:
        return .none
      }
    }
    .ifLet(\.$todoCreate, action: \.todoCreate) {
      TodoCreateViewStore()
    }
  }
  
}
