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
    switch store.state {
    case .root:
      if let store = store.scope(state: \.root, action: \.root) {
        RootView(store: store)
      }
    }
  }
  
}
