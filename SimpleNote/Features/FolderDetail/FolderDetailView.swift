//
//  FolderDetailView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import Entity
import Storage
import SwiftData
import SwiftUI
import ThirdPartyKit

struct FolderDetailView: View {
  
  @Bindable var store: StoreOf<FolderDetailViewStore>
  @Query private var todos: [Todo]
  
  init(store: StoreOf<FolderDetailViewStore>) {
    self.store = store
    let folderID = store.folder?.id
    self._todos = Query(filter: Todo.predicate(folderID: folderID))
  }
  
  var body: some View {
    ZStack {
      VStack {
        navigationBar
          .padding(.horizontal, 20)
        
        ScrollView {
          folderView
            .padding()
          
          listView
            .padding(.horizontal, 20)
          
          Spacer()
            .padding(40)
        }
      }
      .background(.background)
      .frame(maxHeight: .infinity, alignment: .top)
      
      PlusButton(hexColor: store.folder?.hexColor) {
        store.send(.createTapped)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
      .safeAreaPadding(.bottom, 20)
      .safeAreaPadding(.trailing, 20)
      
    }
    .fullScreenCover(item: $store.scope(state: \.todoCreate, action: \.todoCreate)) {
      TodoCreateView(store: $0)
    }
    .fullScreenCover(item: $store.scope(state: \.folderEdit, action: \.folderEdit)) {
      FolderEditView(store: $0)
    }
    .fullScreenCover(item: $store.scope(state: \.todoDetail, action: \.todoDetail)) {
      TodoDetailView(store: $0)
    }
  }
  
}

private extension FolderDetailView {
  
  var navigationBar: some View {
    HStack {
      Button {
        store.send(.closeTapped)
      } label: {
        Image(.arrowLeft)
          .resizable()
          .renderingMode(.template)
          .aspectRatio(contentMode: .fit)
          .frame(width: 30, height: 30)
          .foregroundStyle(.foreground)
      }
      
      Spacer()
      
      if store.folder != nil {
        Button {
          store.send(.editTapped)
        } label: {
          Image(.pencilSimple)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)
            .foregroundStyle(.foreground)
        }
      }
    }
    .frame(height: 50)
  }
  
  var folderView: some View {
    VStack {
      if let title = store.folder?.title {
        Text(title)
          .padding(.top, 20)
          .padding(.horizontal, 20)
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.headline)
          .foregroundStyle(.primary)
      } else {
        Text("None")
          .padding(.top, 20)
          .padding(.horizontal, 20)
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.headline)
          .foregroundStyle(.primary)
      }
      
      Text("\(todos.filter { $0.isComplete.orFalse }.count)/\(todos.count) task done")
        .padding(.horizontal, 20)
        .padding(.bottom, todos.isEmpty ? 20 : 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.caption)
        .foregroundStyle(.primary)
      
      if !todos.isEmpty {
        ProgressView(
          value: Float(todos.filter { $0.isComplete.orFalse }.count),
          total: Float(todos.count)
        )
        .tint(Color(hexOrPrimary: store.folder?.hexColor))
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
      }
    }
    .background(Color(hexOrGray: store.folder?.hexColor).opacity(0.1))
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }
  
  var listView: some View {
    LazyVStack {
      if todos.isEmpty {
        BoxEmptyView(state: .emptyTodo)
      } else {
        ForEach(todos) { todo in
          todoView(todo)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
        }
      }
    }
  }
  
  func todoView(_ todo: Todo) -> some View {
    HStack {
      Button {
        store.send(.checkTapped(todo), animation: .default)
      } label: {
        Image(todo.isComplete.orFalse ? .checkCircleFill : .circle)
          .resizable()
          .renderingMode(.template)
          .frame(width: 30, height: 30)
          .foregroundStyle(Color(hexOrPrimary: store.folder?.hexColor))
      }
      
      Spacer()
        .frame(width: 20)
      
      VStack(alignment: .leading) {
        Text(todo.todo.orEmpty)
          .font(.body)
          .foregroundStyle(todo.isComplete.orFalse ? .secondary : .primary)
        
        Text("\(todo.targetDate.orNow.formatted(date: .complete, time: .omitted))")
          .font(.caption)
          .foregroundStyle(.secondary)
      }
      
      Spacer()
      
      Button {
        store.send(.deleteTapped(todo), animation: .easeInOut)
      } label: {
        Image(.trash)
          .resizable()
          .renderingMode(.template)
          .frame(width: 25, height: 25)
          .foregroundStyle(.red)
      }
    }
    .onTapGesture {
      store.send(.todoTapped(todo))
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
