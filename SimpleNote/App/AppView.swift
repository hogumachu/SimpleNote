//
//  RootView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import ComposableArchitecture
import SwiftUI

struct AppView: View {
  
  let store: StoreOf<AppStore>
  
  var body: some View {
    SwitchStore(store) { state in
      CaseLet(/AppStore.State.home, action: AppStore.Action.home) {
        HomeView(store: $0)
      }
    }
  }
  
}
