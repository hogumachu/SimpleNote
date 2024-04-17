//
//  TodoCreateViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/17/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct TodoCreateViewStore {
  
  @ObservableState
  struct State: Equatable {
    var todo: String
    var targetDate: Date
    
    init(todo: String, targetDate: Date) {
      self.todo = todo
      self.targetDate = targetDate
    }
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    
    case createTapped
    case closeTapped
    
    case delegate(Delegate)
    
    enum Delegate {
      case create(Todo)
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  
  var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .createTapped:
        return .run { [
          todo = state.todo,
          targetDate = state.targetDate
        ] send in
          let todo = Todo(id: .init(), todo: todo, targetDate: targetDate, isComplete: false)
          await send(.delegate(.create(todo)))
          await dismiss()
        }
        
      case .closeTapped:
        return .run { _ in
          await dismiss()
        }
        
      case .delegate:
        return .none
      }
    }
  }
  
}
