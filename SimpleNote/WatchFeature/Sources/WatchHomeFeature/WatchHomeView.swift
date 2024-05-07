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
    List {
      Section {
        ForEach(todos) { todo in
          todoView(todo)
        }
        .onDelete(perform: delete)
      } header: {
        Text("Today's todos", bundle: .module)
          .font(.headline)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.vertical, 5)
      }
    }
  }
  
}

private extension WatchHomeView {
  
  func todoView(_ todo: Todo) -> some View {
    HStack {
      VStack(alignment: .leading) {
        HStack {
          Image(.FolderFill)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(width: 20, height: 20)
            .foregroundStyle(Color(hexOrGray: todo.folder?.hexColor))
          
          if let title = todo.folder?.title {
            Text(title)
              .foregroundStyle(Color(hexOrGray: todo.folder?.hexColor))
          } else {
            Text("None", bundle: .module)
              .foregroundStyle(Color(hexOrGray: todo.folder?.hexColor))
          }
        }
        Text(todo.todo ?? "")
      }
      Spacer()
      
      Image((todo.isComplete ?? false) ? .CheckCircleFill : .Circle)
        .resizable()
        .renderingMode(.template)
        .frame(width: 30, height: 30)
        .foregroundStyle(.foreground)
    }
    .onTapGesture {
      store.send(.todoTapped(todo))
    }
  }
  
  func delete(at offsets: IndexSet) {
    if let first = offsets.first {
      let todo = todos[first]
      store.send(.todoDelete(todo))
    }
  }
  
}
