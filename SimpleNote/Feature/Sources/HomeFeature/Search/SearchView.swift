//
//  SearchView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import FolderFeature
import SwiftUI
import TodoFeature
import UIFeatureKit

public struct SearchView: View {
  
  @Bindable private var store: StoreOf<SearchViewStore>
  @FocusState private var isFocused: Bool
  
  public init(store: StoreOf<SearchViewStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack {
      navigationBar
        .padding(.horizontal, 20)
      
      ScrollView {
        QueryView(searchText: store.searchText) { folders in
          folderListView(folders)
            .padding(20)
        }
        
        QueryView(searchText: store.searchText) { todos in
          todoListView(todos)
            .padding(20)
        }
      }
    }
    .onAppear {
      isFocused = true
    }
    .background(.background)
    .frame(maxHeight: .infinity, alignment: .top)
    .fullScreenCover(item: $store.scope(state: \.todoDetail, action: \.todoDetail)) {
      TodoDetailView(store: $0)
    }
    .navigationDestination(item: $store.scope(state: \.folderDetail, action: \.folderDetail)) {
      FolderDetailView(store: $0)
        .toolbar(.hidden, for: .navigationBar)
    }
  }
  
}

private extension SearchView {
  
  var navigationBar: some View {
    HStack {
      Button {
        store.send(.closeTapped)
      } label: {
        Image(.ArrowLeft)
          .resizable()
          .renderingMode(.template)
          .frame(width: 30, height: 30)
          .foregroundStyle(.foreground)
      }
      
      Spacer()
      
      HStack(alignment: .top) {
        Image(.MagnifyingGlass)
          .resizable()
          .renderingMode(.template)
          .foregroundStyle(.foreground)
          .frame(width: 25, height: 25)
        
        TextField(
          LocalString("Please enter a search term", bundle: .module),
          text: $store.searchText
        )
        .focused($isFocused)
      }
      .padding()
      .frame(maxWidth: .infinity)
      .background(
        RoundedRectangle(cornerRadius: 16)
          .fill(Color.secondarySystemBackground)
      )
    }
    .frame(height: 50)
  }
  
  func folderListView(_ folders: [Folder]) -> some View {
    LazyVStack {
      Text("Folder", bundle: .module)
        .font(.headline)
        .foregroundStyle(.foreground)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      if folders.isEmpty {
        Text("There is no matching folder", bundle: .module)
          .font(.body)
          .foregroundStyle(.gray)
          .padding()
      } else {
        ForEach(folders) { folder in
          FolderView(
            folder: folder,
            onTapped: { store.send(.folderTapped($0)) }
          )
          .frame(maxWidth: .infinity)
        }
      }
    }
  }
  
  func todoListView(_ todos: [Todo]) -> some View {
    LazyVStack {
      Text("Todo", bundle: .module)
        .font(.headline)
        .foregroundStyle(.foreground)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      if todos.isEmpty {
        Text("There is no matching todos", bundle: .module)
          .font(.body)
          .foregroundStyle(.gray)
          .padding()
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
  
}

#Preview {
  SearchView(store: Store(
    initialState: SearchViewStore.State(),
    reducer: {
      SearchViewStore()
    }
  ))
}
