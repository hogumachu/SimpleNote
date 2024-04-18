//
//  FolderCreateView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/16/24.
//

import ComposableArchitecture
import SwiftUI

struct FolderCreateView: View {
  
  @Bindable private var store: StoreOf<FolderCreateViewStore>
  @FocusState private var isFocused: Bool
  
  init(store: StoreOf<FolderCreateViewStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack {
      navigationBar
        .padding(.horizontal, 10)
      
      folderTextField
        .focused($isFocused)
        .padding(.horizontal, 20)
      
      ColorView(
        color: $store.color,
        tap: {
          store.send(.colorChangeTapped)
        }
      )
      .padding(.top, 10)
      .padding(.horizontal, 20)
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Spacer()
      
      createButton
        .padding(.horizontal, 10)
        .safeAreaPadding(.bottom, 20)
    }
    .onAppear {
      isFocused = true
    }
    .frame(maxHeight: .infinity, alignment: .top)
  }
}

private extension FolderCreateView {
  
  var navigationBar: some View {
    HStack {
      Spacer()
      
      Button {
        store.send(.closeTapped)
      } label: {
        Image(systemName: "xmark")
          .resizable()
          .frame(width: 20, height: 20)
          .foregroundStyle(.foreground)
      }
    }
    .frame(height: 50)
  }
  
  var folderTextField: some View {
    TextField("Type folder title", text: $store.title)
      .font(.largeTitle)
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
  
  struct ColorView: View {
  
    @Binding var color: Color
    
    var tap: () -> Void
    
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
          .fill(.ultraThinMaterial)
      )
    }
  }
  
}

#Preview {
  FolderCreateView(
    store: Store(
      initialState: FolderCreateViewStore.State(title: "", hexColor: "F05138"),
      reducer: {
        FolderCreateViewStore()
      }
    )
  )
}
