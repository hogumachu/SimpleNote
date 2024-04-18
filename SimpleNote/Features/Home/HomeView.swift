//
//  HomeView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

struct HomeView: View {
  
  private let store: StoreOf<HomeViewStore>
  @Query private var todos: [Todo]
  @Query private var previousTodos: [Todo]
  
  init(store: StoreOf<HomeViewStore>) {
    self.store = store
    self._todos = Query(filter: Todo.predicate(isSameDayAs: .now))
    self._previousTodos = Query(filter: Todo.predicate(lessThan: .now))
  }
  
  var body: some View {
    VStack {
      navigationBar
        .padding(.horizontal, 10)
      
      ScrollView {
        searchView
          .padding(.horizontal, 20)
        
        todayTodoListView
          .padding(.horizontal, 20)
        
        if !previousTodos.isEmpty {
          previousTodoListView
            .padding(.horizontal, 20)
        }
      }
    }
    .background(.background)
  }
}

private extension HomeView {
  
  var navigationBar: some View {
    HStack {
      Spacer()
      
      Button {
        store.send(.settingTapped)
      } label: {
        Image(.gearFill)
          .resizable()
          .renderingMode(.template)
          .frame(width: 30, height: 30)
          .foregroundStyle(.foreground)
      }
    }
    .frame(height: 50)
  }
  
  var searchView: some View {
    Button {
      store.send(.searchTapped)
    } label : {
      HStack {
        Image(.magnifyingGlass)
          .resizable()
          .renderingMode(.template)
          .foregroundStyle(.foreground)
          .frame(width: 25, height: 25)
        
        Text("Please enter a search term")
          .font(.body)
          .foregroundStyle(.gray)
        
        Spacer()
      }
      .padding()
      .frame(maxWidth: .infinity)
      .background(
        RoundedRectangle(cornerRadius: 16)
          .fill(Color.secondarySystemBackground)
      )
    }
  }
  
  var todayTodoListView: some View {
    LazyVStack {
      Text("Today's todos")
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
      
      if todos.isEmpty {
        EmptyView(subtitle: "There are no todos for today")
      } else {
        ForEach(todos) { todo in
          todoView(todo)
            .frame(maxWidth: .infinity)
        }
      }
    }
  }
  
  var previousTodoListView: some View {
    LazyVStack {
      Text("Uncompleted previous todos")
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
      
      ForEach(previousTodos) { todo in
        todoView(todo)
          .frame(maxWidth: .infinity)
      }
    }
  }
  
  func todoView(_ todo: Todo) -> some View {
    HStack {
      VStack(alignment: .leading) {
        HStack(spacing: 3) {
          Image(.folderFill)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(width: 20, height: 20)
            .foregroundStyle(Color(hex: todo.folder?.hexColor ?? "#9f9f9f"))
          
          Text(todo.folder?.title ?? "Empty Folder")
            .font(.callout)
            .foregroundStyle(Color(hex: todo.folder?.hexColor ?? "#9f9f9f"))
        }
        
        Text(todo.todo)
          .font(.body)
          .foregroundStyle(todo.isComplete ? .secondary : .primary)
        
        Text("\(todo.targetDate.formatted(date: .complete, time: .omitted))")
          .font(.caption)
          .foregroundStyle(.secondary)
      }
      
      Spacer()
      
      Button {
        _ = withAnimation {
          store.send(.checkTapped(todo))
        }
      } label: {
        Image(todo.isComplete ? .checkCircleFill : .circle)
          .resizable()
          .renderingMode(.template)
          .frame(width: 30, height: 30)
          .foregroundStyle(.foreground)
      }
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 16)
        .foregroundStyle(Color.secondarySystemBackground)
    )
    .onTapGesture {
      store.send(.todoTapped(todo))
    }
  }
  
}

#Preview {
  HomeView(store: Store(
    initialState: HomeViewStore.State(),
    reducer: {
      HomeViewStore()
    }
  ))
}
