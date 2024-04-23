//
//  SearchViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import Foundation
import UIFeatureKit

@Reducer
struct SearchViewStore {
  
  @ObservableState
  struct State: Equatable {
    var searchText: String
    @Presents var todoDetail: TodoDetailViewStore.State?
    @Presents var folderDetail: FolderDetailViewStore.State?
    
    init(searchText: String = "") {
      self.searchText = searchText
    }
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    
    case closeTapped
    case folderTapped(Folder)
    case todoTapped(Todo)
    case checkTapped(Todo)
    case todoDetail(PresentationAction<TodoDetailViewStore.Action>)
    case folderDetail(PresentationAction<FolderDetailViewStore.Action>)
  }
  
  @Dependency(\.dismiss) private var dismiss
  
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
        
      case let .folderTapped(folder):
        state.folderDetail = .init(folder: folder)
        return .none
        
      case let .todoTapped(todo):
        state.todoDetail = .init(todo: todo)
        return .none
        
      case let .checkTapped(todo):
        todo.isComplete?.toggle()
        return .none
        
      case .todoDetail:
        return .none
        
      case .folderDetail:
        return .none
      }
    }
    .ifLet(\.$todoDetail, action: \.todoDetail) {
      TodoDetailViewStore()
    }
    .ifLet(\.$folderDetail, action: \.folderDetail) {
      FolderDetailViewStore()
    }
  }
  
}
