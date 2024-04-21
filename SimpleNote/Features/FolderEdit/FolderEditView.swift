//
//  FolderEditView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/18/24.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

struct FolderEditView: View {
  
  @Bindable private var store: StoreOf<FolderEditViewStore>
  @FocusState private var isFocused: Bool
  
  init(store: StoreOf<FolderEditViewStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack {
      NavigationBar(style: .close) {
        store.send(.closeTapped)
      }
      .padding(.horizontal, 20)
      
      ScrollView {
        folderTextField
          .focused($isFocused)
          .padding(.horizontal, 20)
        
        ColorView(color: $store.color)
        .padding(.top, 10)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        
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
    .onAppear {
      isFocused = true
    }
    .frame(maxHeight: .infinity, alignment: .top)
    .alert($store.scope(state: \.alert, action: \.alert))
  }
}

private extension FolderEditView {
  
  var folderTextField: some View {
    TextField("Type folder title", text: $store.title)
      .font(.largeTitle)
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
  
  struct ColorView: View {
  
    @Binding var color: Color
    
    var body: some View {
      HStack {
        ColorPicker(
          selection: $color,
          label: {
            Text("Select Color")
              .foregroundStyle(.foreground)
          }
        )
      }
      .padding(10)
      .background(
        RoundedRectangle(cornerRadius: 20, style: .circular)
          .fill(Color.secondarySystemBackground)
      )
    }
  }
  
}

#Preview {
  let container = ModelContainer.preview()
  let folder = Folder(id: .init(), title: "Simple note app develop", hexColor: "#A0E022")
  
  return FolderEditView(
    store: Store(
      initialState: FolderEditViewStore.State(folder: folder),
      reducer: {
        FolderEditViewStore()
      }
    )
  )
  .modelContainer(container)
}
