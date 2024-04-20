//
//  SettingView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/20/24.
//

import ComposableArchitecture
import SwiftUI

struct SettingView: View {
  
  @Bindable private var store: StoreOf<SettingViewStore>
  
  @AppStorage(UserDefaultsKey.hideCompleteTodo.rawValue)
  private var hideCompleteTodo: Bool = false
  
  init(store: StoreOf<SettingViewStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack {
      navigationBar
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
  
  var navigationBar: some View {
    HStack {
      Button {
        store.send(.closeTapped)
      } label: {
        Image(.arrowLeft)
          .resizable()
          .renderingMode(.template)
          .frame(width: 30, height: 30)
          .foregroundStyle(.foreground)
      }
      
      Spacer()
    }
    .frame(height: 50)
  }
  
  var settingListView: some View {
    List(store.settingItems) { item in
      switch item {
      case .hideCompleteTodo:
        Toggle(item.title, isOn: $hideCompleteTodo)
        
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
