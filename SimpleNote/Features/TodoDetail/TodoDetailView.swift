//
//  TodoDetailView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import ComposableArchitecture
import SwiftUI

struct TodoDetailView: View {
  
  @Bindable private var store: StoreOf<TodoDetailViewStore>
  
  init(store: StoreOf<TodoDetailViewStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack {
      navigationBar
        .padding(.horizontal, 10)
      
      todoTextField
        .padding(.horizontal, 20)
      
      datePicker
        .padding(.top, 10)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
      
      Spacer()
      
      HStack {
        deleteButton
        editButton
      }
      .padding(.horizontal, 10)
      .safeAreaPadding(.bottom, 20)
    }
    .frame(maxHeight: .infinity, alignment: .top)
    .background(.background)
  }
  
}

private extension TodoDetailView {
  
  var navigationBar: some View {
    HStack {
      Spacer()
      
      Button {
        store.send(.closeTapped)
      } label: {
        Image(.X)
          .resizable()
          .renderingMode(.template)
          .aspectRatio(contentMode: .fit)
          .frame(width: 30, height: 30)
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
        .fill(Color.secondarySystemBackground)
    )
  }
  
  var deleteButton: some View {
    Button {
      store.send(.deleteTapped)
    } label: {
      Text("Delete")
        .frame(maxWidth: .infinity)
        .foregroundStyle(.background)
        .font(.headline)
    }
    .background(
      RoundedRectangle(cornerRadius: 20, style: .circular)
        .fill(.red)
        .frame(height: 50)
    )
  }
  
  var editButton: some View {
    Button {
      store.send(.editTapped)
    } label: {
      Text("Edit")
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
  TodoDetailView(store: Store(
    initialState: TodoDetailViewStore.State(
      todo: .init(id: .init(), todo: "Todo 1", targetDate: .now, isComplete: false)
    ),
    reducer: {
      TodoDetailViewStore()
    }
  ))
}
