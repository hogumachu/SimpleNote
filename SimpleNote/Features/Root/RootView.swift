//
//  RootView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
  
  let store: StoreOf<RootViewStore>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      tabView(viewStore)
    }
  }
}

private extension RootView {
  
  func tabView(_ viewStore: ViewStoreOf<RootViewStore>) -> some View {
    TabView {
      ForEach(viewStore.state.tabs, id: \.self) { tab in
        let title = tab.title
        let image = tab.image
        
        switch tab {
        case .home:
          IfLetStore(store.scope(state: \.home, action: \.home)) {
            HomeView(store: $0)
              .tabItem {
                Label(
                  title: { Text(title) },
                  icon: { Image(systemName: image) }
                )
              }
          }
        case .folder:
          IfLetStore(store.scope(state: \.folder, action: \.folder)) {
            FolderHomeView(store: $0)
              .tabItem {
                Label(
                  title: { Text(title) },
                  icon: { Image(systemName: image) }
                )
              }
          }
        }
      }
      
    }
  }
  
}
