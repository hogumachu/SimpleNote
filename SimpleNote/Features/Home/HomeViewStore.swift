//
//  HomeViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct HomeViewStore: Reducer {
  
  @ObservableState
  struct State: Equatable {
    @Presents var todoDetail: TodoDetailViewStore.State?
    var path = StackState<SearchViewStore.State>()
  }
  
  enum Action {
    case searchTapped
    case todoTapped(Todo)
    case checkTapped(Todo)
    case settingTapped
    case todoDetail(PresentationAction<TodoDetailViewStore.Action>)
    case path(StackAction<SearchViewStore.State, SearchViewStore.Action>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .searchTapped:
        return .none
        
      case let .todoTapped(todo):
        state.todoDetail = .init(todo: todo)
        return .none
        
      case let .checkTapped(todo):
        todo.isComplete?.toggle()
        return .none
        
      case .settingTapped:
        return .none
        
      case .todoDetail:
        return .none
        
      case .path:
        return .none
      }
    }
    .ifLet(\.$todoDetail, action: \.todoDetail) {
      TodoDetailViewStore()
    }
    .forEach(\.path, action: \.path) {
      SearchViewStore()
    }
  }
  
}
