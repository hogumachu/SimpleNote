//
//  FolderDetailView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

struct FolderDetailView: View {
  
  @Bindable var store: StoreOf<FolderDetailViewStore>
  @Query private var todos: [Todo]
  
  init(store: StoreOf<FolderDetailViewStore>) {
    self.store = store
    let folderID = store.folder.id
    self._todos = Query(filter: #Predicate {
      $0.folder?.id == folderID
    })
  }
  
  var body: some View {
    ZStack {
      VStack {
        navigationBar
        
        ScrollView {
          folderView
            .padding()
          
          listView
            .padding(.horizontal, 20)
        }
      }
      .background(.background)
      .frame(maxHeight: .infinity, alignment: .top)
      .sheet(item: $store.scope(state: \.todoCreate, action: \.todoCreate)) {
        TodoCreateView(store: $0)
      }
      
      createView
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .safeAreaPadding(.bottom, 20)
        .safeAreaPadding(.trailing, 20)
    }
  }
  
}

private extension FolderDetailView {
  
  var navigationBar: some View {
    HStack {
      Button {
        store.send(.closeTapped)
      } label: {
        Image(systemName: "arrow.left")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 20, height: 20)
          .foregroundStyle(.foreground)
      }
      
      Spacer()
      
      Button {
        store.send(.editTapped)
      } label: {
        Image(systemName: "pencil")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 16, height: 16)
          .foregroundStyle(.foreground)
      }
    }
    .frame(height: 50)
    .padding(.horizontal, 10)
  }
  
  var folderView: some View {
    VStack {
      Text("\(todos.filter { $0.isComplete }.count)/\(todos.count) task done")
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.callout)
        .foregroundStyle(.secondary)
      
      Text(store.folder.title)
        .padding(.horizontal, 20)
        .padding(.bottom, todos.isEmpty ? 20 : 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
        .foregroundStyle(.primary)
      
      if !todos.isEmpty {
        ProgressView(
          value: Float(todos.filter { $0.isComplete }.count),
          total: Float(todos.count)
        )
        .tint(Color(hex: store.folder.hexColor))
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
      }
    }
    .background(.ultraThinMaterial)
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }
  
  var listView: some View {
    LazyVStack {
      if todos.isEmpty {
        emptyTodoView
      } else {
        ForEach(todos) { todo in
          todoView(todo)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
        }
      }
    }
  }
  
  var emptyTodoView: some View {
    Text("Todo is empty")
      .font(.body)
      .foregroundStyle(.gray)
      .padding()
  }
  
  var createView: some View {
    Button {
      store.send(.createTapped)
    } label: {
      Image(systemName: "plus.circle.fill")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 50, height: 50)
    }
    .foregroundStyle(Color(hex: store.folder.hexColor))
  }
  
  func todoView(_ todo: Todo) -> some View {
    HStack {
      Button {
        _ = withAnimation {
          store.send(.checkTapped(todo))
        }
      } label: {
        Image(systemName: todo.isComplete ? "checkmark.circle.fill" : "circle")
          .resizable()
          .frame(width: 25, height: 25)
          .foregroundStyle(Color(hex: store.folder.hexColor))
      }
      
      Spacer()
        .frame(width: 20)
      
      VStack(alignment: .leading) {
        Text(todo.todo)
          .font(.body)
          .foregroundStyle(todo.isComplete ? .secondary : .primary)
        
        Text("\(todo.targetDate)")
          .font(.caption)
          .foregroundStyle(.secondary)
      }
      
      Spacer()
      
      Button {
        _ = withAnimation(.easeInOut) {
          store.send(.deleteTapped(todo))
        }
      } label: {
        Image(systemName: "trash")
          .foregroundStyle(.red)
      }
    }
  }
  
}

#Preview {
  let container = ModelContainer.preview()
  let folder = Folder(id: .init(), title: "Simple note app develop", hexColor: "#A0E022")
  let todos: [Todo] = [
    .init(id: .init(), todo: "Todo 1", targetDate: .init(), isComplete: true),
    .init(id: .init(), todo: "Todo 2", targetDate: .init(), isComplete: false),
    .init(id: .init(), todo: "Todo 3", targetDate: .init(), isComplete: false),
  ]
  
  for todo in todos {
    container.mainContext.insert(todo)
  }
  
  folder.todos = todos
  
  return FolderDetailView(store: Store(
    initialState: FolderDetailViewStore.State(
      folder: folder
    ),
    reducer: {
      FolderDetailViewStore()
        .dependency(\.database, Database(context: {container.mainContext}))
    }
  ))
  .modelContainer(container)
}
