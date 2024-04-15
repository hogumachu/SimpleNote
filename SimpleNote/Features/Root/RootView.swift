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
      let title = viewStore.state.tab.title
      let image = viewStore.state.tab.image
      
      switch viewStore.state.tab {
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
      }
    }
  }
  
}
