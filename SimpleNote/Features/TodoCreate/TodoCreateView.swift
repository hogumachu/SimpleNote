//
//  TodoCreateView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/17/24.
//

import ComposableArchitecture
import SwiftUI

struct TodoCreateView: View {
  
  @Bindable private var store: StoreOf<TodoCreateViewStore>
  @FocusState private var isFocused: Bool
  
  init(store: StoreOf<TodoCreateViewStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack {
      navigationBar
        .padding(.horizontal, 10)
      
      todoTextField
        .focused($isFocused)
        .padding(.horizontal, 20)
      
      datePicker
        .padding(.top, 10)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
      
      Spacer()
      
      createButton
        .padding(.horizontal, 10)
        .safeAreaPadding(.bottom, 20)
    }
    .onAppear {
      isFocused = true
    }
    .frame(maxHeight: .infinity, alignment: .top)
    .background(.background)
  }
  
}

private extension TodoCreateView {
  
  var navigationBar: some View {
    HStack {
      Spacer()
      
      Button {
        store.send(.closeTapped)
      } label: {
        Image(systemName: "xmark")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 20, height: 20)
          .foregroundStyle(.foreground)
      }
    }
    .frame(height: 50)
  }
  
  var todoTextField: some View {
    TextField("Type todo", text: $store.todo)
      .font(.largeTitle)
  }
  
  var datePicker: some View {
    HStack {
      DatePicker(
        selection: $store.targetDate,
        displayedComponents: .date,
        label: {
          Text("Select Target Date")
        }
      )
    }
    .padding(10)
    .background(
      RoundedRectangle(cornerRadius: 20, style: .circular)
        .fill(.ultraThinMaterial)
    )
  }
  
  var createButton: some View {
    Button {
      store.send(.createTapped)
    } label: {
      Text("Create")
        .frame(maxWidth: .infinity)
        .foregroundStyle(.background)
        .font(.headline)
    }
    .background(
      RoundedRectangle(cornerRadius: 20, style: .circular)
        .fill(.foreground)
        .frame(height: 50)
    )
  }
  
}

#Preview {
  TodoCreateView(store: Store(
    initialState: TodoCreateViewStore.State(todo: "", targetDate: .now),
    reducer: {
      TodoCreateViewStore()
    }
  ))
}
