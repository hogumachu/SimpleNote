//
//  HomeViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import Foundation
import SettingFeature
import TodoFeature
import UIFeatureKit

@Reducer
public struct HomeViewStore: Reducer {
  
  @Reducer(state: .equatable)
  public enum Path {
    case search(SearchViewStore)
    case setting(SettingViewStore)
  }
  
  @ObservableState
  public struct State: Equatable {
    @Presents public var todoDetail: TodoDetailViewStore.State?
    @Presents public var todoCreate: TodoCreateViewStore.State?
    public var path: StackState<Path.State>
    
    public init(todoDetail: TodoDetailViewStore.State? = nil, todoCreate: TodoCreateViewStore.State? = nil, path: StackState<Path.State> = StackState<Path.State>()) {
      self.todoDetail = todoDetail
      self.todoCreate = todoCreate
      self.path = path
    }
  }
  
  public enum Action {
    case searchTapped
    case todoTapped(Todo)
    case checkTapped(Todo)
    case createTapped
    case settingTapped
    case todoDetail(PresentationAction<TodoDetailViewStore.Action>)
    case todoCreate(PresentationAction<TodoCreateViewStore.Action>)
    case path(StackAction<Path.State, Path.Action>)
  }
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .searchTapped:
        state.path.append(.search(SearchViewStore.State()))
        return .none
        
      case let .todoTapped(todo):
        state.todoDetail = .init(todo: todo)
        return .none
        
      case let .checkTapped(todo):
        todo.isComplete?.toggle()
        return .none
        
      case .createTapped:
        @Dependency(\.date.now) var now
        state.todoCreate = .init(
          todo: "",
          targetDate: now,
          folder: nil
        )
        return .none
        
      case .settingTapped:
        state.path.append(.setting(SettingViewStore.State()))
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
    .forEach(\.path, action: \.path)
  }
  
}
