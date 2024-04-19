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
  @Query private var todos: [Todo]
  @Query private var previousTodos: [Todo]
  
  init(store: StoreOf<HomeViewStore>) {
    self.store = store
    self._todos = Query(filter: Todo.predicate(isSameDayAs: .now))
    self._previousTodos = Query(filter: Todo.predicate(lessThan: .now))
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
            
            todayTodoListView
              .padding(.horizontal, 20)
            
            if !previousTodos.isEmpty {
              previousTodoListView
                .padding(.horizontal, 20)
            }
          }
        }
        .background(.background)
        
        createView
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
          .safeAreaPadding(.bottom, 20)
          .safeAreaPadding(.trailing, 20)
      }
    } destination: {
      SearchView(store: $0)
        .toolbar(.hidden, for: .tabBar)
        .toolbar(.hidden, for: .navigationBar)
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
    NavigationLink(state: SearchViewStore.State()) {
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
