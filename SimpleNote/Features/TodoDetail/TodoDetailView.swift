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
    NavigationStack {
      VStack {
        NavigationBar(style: .close) {
          store.send(.closeTapped)
        }
        .padding(.horizontal, 20)
        
        ScrollView {
          todoTextField
            .padding(.horizontal, 20)
          
          datePicker
            .padding(.top, 10)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
          
          folderPicker
            .padding(.top, 10)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
          
          Spacer()
        }.safeAreaInset(edge: .bottom) {
          HStack {
            deleteButton
            editButton
          }
          .padding(.horizontal, 10)
          .padding(.bottom, 20)
        }
      }
      .navigationDestination(item: $store.scope(state: \.folderPicker, action: \.folderPicker)) {
        FolderPickerView(store: $0)
          .toolbar(.hidden, for: .navigationBar)
      }
    }
    .frame(maxHeight: .infinity, alignment: .top)
    .background(.background)
    
  }
  
}

private extension TodoDetailView {
  
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
  
  var folderPicker: some View {
    Button {
      store.send(.folderTapped)
    } label: {
      HStack {
        Text("Selected folder")
          .font(.body)
          .foregroundStyle(.foreground)
        
        Spacer()
        
        Image(.folderFill)
          .resizable()
          .renderingMode(.template)
          .aspectRatio(contentMode: .fit)
          .frame(width: 20, height: 20)
          .foregroundStyle(Color(hexOrGray: store.folder?.hexColor))
        
        if let title = store.folder?.title {
          Text(title)
            .font(.body)
            .foregroundStyle(.foreground)
        } else {
          Text("None")
            .font(.body)
            .foregroundStyle(.foreground)
        }
      }
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 15)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .foregroundStyle(Color.secondarySystemBackground)
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
