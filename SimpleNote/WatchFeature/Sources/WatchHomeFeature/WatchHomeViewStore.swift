//
//  WatchHomeViewStore.swift
//
//
//  Created by 홍성준 on 4/28/24.
//

import SwiftUI
import WatchFeatureKit

@Reducer
public struct WatchHomeViewStore {
  
  public struct State: Equatable {
    
    public init() {}
  }
  
  public enum Action {
    case todoTapped(Todo)
    case todoDelete(Todo)
  }
  
  @Dependency(\.todoDatabase) private var todoDatebase
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .todoTapped(todo):
        todo.isComplete?.toggle()
        return .none
        
      case let .todoDelete(todo):
        return .run { send in
          try todoDatebase.delete(todo)
        }
      }
    }
  }
  
}
