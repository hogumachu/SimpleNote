//
//  RootView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import SwiftUI
import ThirdPartyKit

struct RootView: View {
  
  @Bindable private var store: StoreOf<RootViewStore>
  
  init(store: StoreOf<RootViewStore>) {
    self.store = store
  }
  
  var body: some View {
    TabView(selection: $store.selectedTab.sending(\.tabSelected)) {
      HomeView(store: store.scope(state: \.home, action: \.home))
        .tabItem { RootTab.home.tabItem(isSelected: store.selectedTab == .home) }
        .tag(RootTab.home)
      
      CalendarHomeView(store: store.scope(state: \.calendar, action: \.calendar))
        .tabItem { RootTab.calendar.tabItem(isSelected: store.selectedTab == .calendar) }
        .tag(RootTab.calendar)
      
      FolderHomeView(store: store.scope(state: \.folder, action: \.folder))
        .tabItem { RootTab.folder.tabItem(isSelected: store.selectedTab == .folder) }
        .tag(RootTab.folder)
    }
    .tint(.primary)
  }
  
}
