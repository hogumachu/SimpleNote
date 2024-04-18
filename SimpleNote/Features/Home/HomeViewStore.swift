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
    
  }
  
  enum Action {
    case searchTapped
    case todoTapped(Todo)
    case checkTapped(Todo)
    case settingTapped
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .searchTapped:
        return .none
        
      case let .todoTapped(todo):
        return .none
        
      case let .checkTapped(todo):
        todo.isComplete.toggle()
        return .none
        
      case .settingTapped:
        return .none
      }
    }
  }
  
}
