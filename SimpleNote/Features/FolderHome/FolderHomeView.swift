//
//  FolderHomeView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import ComposableArchitecture
import SwiftUI

struct FolderHomeView: View {
  
  @Bindable var store: StoreOf<FolderHomeViewStore>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      NavigationStack(
        path: $store.scope(state: \.path, action: \.path)
      ) {
        Text("Folder Home")
      } destination: { store in
        destination(store)
      }
    }
  }
  
}

private extension FolderHomeView {
  
  func destination(_ store: StoreOf<FolderHomeViewStore.Path>) -> some View {
    switch store.case {
    case let .detail(store):
      return FolderDetailView(store: store)
    }
  }
  
}
