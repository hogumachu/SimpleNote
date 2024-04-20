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
  
  @Bindable private var store: StoreOf<HomeViewStore>
  
  @AppStorage(UserDefaultsKey.hideCompleteTodo.rawValue)
  private var hideCompleteTodo = false
  
  init(store: StoreOf<HomeViewStore>) {
    self.store = store
  }
  
  var body: some View {
    NavigationStack(
      path: $store.scope(state: \.path, action: \.path)
    ) {
      ZStack {
        VStack(spacing: 0) {
          navigationBar
            .padding(.horizontal, 20)
          
          Divider()
            .padding(.top, 10)
          
          ScrollView {
            searchView
              .padding(20)
            
            QueryView(isSameDayAs: .now, hideCompleteTodo: hideCompleteTodo) { todos in
              todayTodoListView(todos)
                .padding(.horizontal, 20)
            }
            
            QueryView(lessThan: .now) { todos in
              if !todos.isEmpty {
                previousTodoListView(todos)
                  .padding(.horizontal, 20)
              }
            }
          }
        }
        .background(.background)
        
        createView
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
          .safeAreaPadding(.bottom, 20)
          .safeAreaPadding(.trailing, 20)
      }
    } destination: { store in
      switch store.case {
      case let .search(store):
        SearchView(store: store)
          .toolbar(.hidden, for: .tabBar)
          .toolbar(.hidden, for: .navigationBar)
        
      case let .setting(store):
        SettingView(store: store)
          .toolbar(.hidden, for: .tabBar)
          .toolbar(.hidden, for: .navigationBar)
      }
    }
    .fullScreenCover(item: $store.scope(state: \.todoDetail, action: \.todoDetail)) {
      TodoDetailView(store: $0)
    }
    .fullScreenCover(item: $store.scope(state: \.todoCreate, action: \.todoCreate)) {
      TodoCreateView(store: $0)
    }
  }
}

private extension HomeView {
  
  var navigationBar: some View {
    HStack {
      Text("Home")
        .font(.headline)
      
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
    } label: {
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
  
  func todayTodoListView(_ todos: [Todo]) -> some View {
    LazyVStack {
      Text("Today's todos")
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
      
      if todos.isEmpty {
        BoxEmptyView(state: .emptyTodoForToday)
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
  
  func previousTodoListView(_ previousTodos: [Todo]) -> some View {
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
  
  var createView: some View {
    Button {
      store.send(.createTapped)
    } label: {
      Image(.plusCircleFill)
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(width: 50, height: 50)
    }
    .foregroundStyle(.foreground)
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
