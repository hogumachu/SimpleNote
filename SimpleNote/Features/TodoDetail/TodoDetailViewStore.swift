//
//  TodoDetailViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct TodoDetailViewStore {
  
  @ObservableState
  struct State: Equatable {
    fileprivate var origin: Todo
    var todo: String
    var targetDate: Date
    
    init(todo: Todo) {
      self.origin = todo
      self.todo = todo.todo
      self.targetDate = todo.targetDate
    }
  }
  
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    
    case closeTapped
    case deleteTapped
    case editTapped
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
        return .run { send in
          await dismiss()
        }
      }
    }
  }
  
}
