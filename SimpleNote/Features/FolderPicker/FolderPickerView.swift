//
//  FolderPickerView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

struct FolderPickerView: View {
  
  private let store: StoreOf<FolderPickerViewStore>
  
  init(store: StoreOf<FolderPickerViewStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack {
      navigationBar
        .padding(.horizontal, 20)
      
      
      QueryView(descriptor: FetchDescriptor<Folder>()) { folders in
        if folders.isEmpty {
          Spacer()
          
          EmptyView(subtitle: "There is no folder")
          
          Spacer()
        } else {
          ScrollView {
            folderListView(folders)
              .padding(.horizontal, 20)
          }
        }
      }
    }
    .background(.background)
    .frame(maxHeight: .infinity, alignment: .top)
  }
  
}

private extension FolderPickerView {
  
  var navigationBar: some View {
    HStack {
      Button {
        store.send(.closeTapped)
      } label: {
        Image(.arrowLeft)
          .resizable()
          .renderingMode(.template)
          .aspectRatio(contentMode: .fit)
          .frame(width: 30, height: 30)
          .foregroundStyle(.foreground)
      }
      
      Spacer()
    }
    .frame(height: 50)
  }
  
  func folderListView(_ folders: [Folder]) -> some View {
    LazyVStack {
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
