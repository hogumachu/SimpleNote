//
//  WatchHomeView.swift
//
//
//  Created by 홍성준 on 4/28/24.
//

import SwiftData
import SwiftUI
import WatchFeatureKit

public struct WatchHomeView: View {
  
  @Query private var todos: [Todo]
  private var store: StoreOf<WatchHomeViewStore>
  
  public init(store: StoreOf<WatchHomeViewStore>) {
    self._todos = Query(.init(predicate: Todo.predicate(
      isSameDayAs: .now,
      hideCompleteTodo: false
    )))
    self.store = store
  }
  
  public var body: some View {
    ScrollView {
      todayTodoListView(todos)
    }
  }
  
}

private extension WatchHomeView {
  
  // TODO: - Update UI
  func todayTodoListView(_ todos: [Todo]) -> some View {
    LazyVStack {
      Text("Today's todos")
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
      
      ForEach(todos) { todo in
        VStack {
          Text(todo.todo ?? "")
          Text(todo.folder?.title ?? "")
        }
      }
    }
  }
  
}
