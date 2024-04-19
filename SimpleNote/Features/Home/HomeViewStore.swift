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
    @Presents var todoCreate: TodoCreateViewStore.State?
    var path = StackState<SearchViewStore.State>()
  }
  
  enum Action {
    case searchTapped
    case todoTapped(Todo)
    case checkTapped(Todo)
    case createTapped
    case settingTapped
    case todoDetail(PresentationAction<TodoDetailViewStore.Action>)
    case todoCreate(PresentationAction<TodoCreateViewStore.Action>)
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
        
      case .createTapped:
        state.todoCreate = .init(
          todo: "",
          targetDate: .now,
          folder: nil
        )
        return .none
        
      case .settingTapped:
        return .none
        
      case .todoDetail:
        return .none
        
      case .todoCreate:
        return .none
        
      case .path:
        return .none
      }
    }
    .ifLet(\.$todoDetail, action: \.todoDetail) {
      TodoDetailViewStore()
    }
    .ifLet(\.$todoCreate, action: \.todoCreate) {
      TodoCreateViewStore()
    }
    .forEach(\.path, action: \.path) {
      SearchViewStore()
    }
  }
  
}
