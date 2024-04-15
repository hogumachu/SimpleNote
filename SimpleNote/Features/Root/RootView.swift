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
  
  @ViewBuilder
  func tabView(_ viewStore: ViewStoreOf<RootViewStore>) -> some View {
    TabView(
      selection: viewStore.binding(
        get: \.selectedTab,
        send: RootViewStore.Action.tabSelected
      )
    ) {
      HomeView(store: store.scope(state: \.home, action: \.home))
        .tabItem { RootTab.home.tabItem }
        .tag(RootTab.home)
      
      FolderHomeView(store: store.scope(state: \.folder, action: \.folder))
        .tabItem { RootTab.folder.tabItem }
        .tag(RootTab.folder)
      
    }
  }
  
}
