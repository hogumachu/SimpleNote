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
          TodoView(
            todo: todo,
            checkTapped: { store.send(.checkTapped($0)) },
            onTapped: { store.send(.todoTapped($0)) }
          )
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
        TodoView(
          todo: todo,
          checkTapped: { store.send(.checkTapped($0)) },
          onTapped: { store.send(.todoTapped($0)) }
        )
        .frame(maxWidth: .infinity)
      }
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
