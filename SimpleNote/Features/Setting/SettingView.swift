//
//  SettingView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/20/24.
//

import SwiftUI
import ThirdPartyKit

struct SettingView: View {
  
  @Bindable private var store: StoreOf<SettingViewStore>
  
  @AppStorage(UserDefaultsKey.hideCompleteTodo.rawValue)
  private var hideCompleteTodo: Bool = false
  
  init(store: StoreOf<SettingViewStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack {
      NavigationBar(style: .back) {
        store.send(.closeTapped)
      }
      .padding(.horizontal, 20)
      
      settingListView
    }
    .onAppear {
      store.send(.onAppear)
    }
    .background(.background)
    .frame(maxHeight: .infinity, alignment: .top)
    .alert($store.scope(state: \.alert, action: \.alert))
  }
  
}

private extension SettingView {
  
  var settingListView: some View {
    List(store.settingItems) { item in
      switch item {
      case .hideCompleteTodo:
        Toggle(item.title, isOn: $hideCompleteTodo)
          .tint(.blue)
        
      case .version:
        HStack {
          Text(item.title)
          
          Spacer()
          
          Text(store.appVersion)
            .font(.callout)
            .foregroundStyle(.gray)
        }
        
      case .deleteAll:
        Button {
          store.send(.deleteAllTapped)
        } label: {
          Text(item.title)
        }
      }
    }
    .listStyle(.plain)
  }
  
}

#Preview {
  SettingView(store: Store(
    initialState: SettingViewStore.State(),
    reducer: {
      SettingViewStore()
    }
  ))
}
