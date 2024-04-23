//
//  HomeView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import SettingFeature
import SwiftData
import SwiftUI
import UIFeatureKit

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
          NavigationBar(style: .titleWithButton(LocalString("Home", bundle: .module), .GearFill)) {
            store.send(.settingTapped)
          }
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
            
            QueryView(
              greaterThanEqaul: .now + 1.days,
              lessThan: .now + 7.days,
              hideCompleteTodo: hideCompleteTodo
            ) { todos in
              if !todos.isEmpty {
                upcomingTodoListView(todos)
                  .padding(.horizontal, 20)
              }
            }
            
            Spacer()
              .padding(40)
          }
        }
        .background(.background)
        
        PlusButton { store.send(.createTapped) }
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
          .safeAreaPadding([.bottom, .trailing], 20)
      }
    } destination: { store in
      switch store.case {
      case let .search(store):
        SearchView(store: store)
          .toolbar(.hidden, for: .tabBar, .navigationBar)
        
      case let .setting(store):
        SettingView(store: store)
          .toolbar(.hidden, for: .tabBar, .navigationBar)
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
  
  var searchView: some View {
    Button {
      store.send(.searchTapped)
    } label: {
      HStack {
        Image(.MagnifyingGlass)
          .resizable()
          .renderingMode(.template)
          .foregroundStyle(.foreground)
          .frame(width: 25, height: 25)
        
        Text("Please enter a search term", bundle: .module)
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
      Text("Today's todos", bundle: .module)
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
      Text("Uncompleted previous todos", bundle: .module)
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
  
  func upcomingTodoListView(_ previousTodos: [Todo]) -> some View {
    LazyVStack {
      Text("Upcoming todos", bundle: .module)
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
