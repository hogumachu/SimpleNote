//
//  FolderPickerView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import FeatureKit
import SwiftData
import SwiftUI

struct FolderPickerView: View {
  
  private let store: StoreOf<FolderPickerViewStore>
  
  init(store: StoreOf<FolderPickerViewStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack {
      NavigationBar(style: .back) {
        store.send(.closeTapped)
      }
      .padding(.horizontal, 20)
      
      QueryView(descriptor: FetchDescriptor<Folder>()) { folders in
        if folders.isEmpty {
          Spacer()
          
          BoxEmptyView(state: .emptyFolderWithCreateDescription)
          
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
