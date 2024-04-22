//
//  TodoCreateView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/17/24.
//

import FeatureKit
import SwiftUI

struct TodoCreateView: View {
  
  @Bindable private var store: StoreOf<TodoCreateViewStore>
  @FocusState private var isFocused: Bool
  
  init(store: StoreOf<TodoCreateViewStore>) {
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
            .focused($isFocused)
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
        }
        .safeAreaInset(edge: .bottom) {
          createButton
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
        }
      }
      .navigationDestination(item: $store.scope(state: \.folderPicker, action: \.folderPicker)) {
        FolderPickerView(store: $0)
          .toolbar(.hidden, for: .navigationBar)
      }
    }
    .onAppear {
      isFocused = true
    }
    .frame(maxHeight: .infinity, alignment: .top)
    .background(.background)
    
  }
  
}

private extension TodoCreateView {
  
  var todoTextField: some View {
    TextField(LocalString("Type todo", bundle: .module), text: $store.todo)
      .font(.largeTitle)
  }
  
  var datePicker: some View {
    HStack {
      DatePicker(
        selection: $store.targetDate,
        displayedComponents: .date,
        label: {
          Text("Select Target Date", bundle: .module)
            .font(.body)
            .foregroundStyle(.foreground)
        }
      )
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 10)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .foregroundStyle(Color.secondarySystemBackground)
    )
  }
  
  var folderPicker: some View {
    Button {
      store.send(.folderTapped)
    } label: {
      HStack {
        Text("Selected folder", bundle: .module)
          .font(.body)
          .foregroundStyle(.foreground)
        
        Spacer()
        
        Image(.FolderFill)
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
          Text("None", bundle: .module)
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
  
  var createButton: some View {
    Button {
      store.send(.createTapped)
    } label: {
      Text("Create", bundle: .module)
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
    initialState: TodoCreateViewStore.State(todo: "", targetDate: .now, folder: nil),
    reducer: {
      TodoCreateViewStore()
    }
  ))
}
