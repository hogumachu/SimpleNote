//
//  RootViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import CalendarFeature
import FolderFeature
import Foundation
import HomeFeature
import UIFeatureKit

@Reducer
struct RootViewStore: Reducer {
  
  @ObservableState
  struct State: Equatable {
    var selectedTab: RootTab = .home
    var home: HomeViewStore.State = .init()
    var calendar: CalendarHomeViewStore.State = .init()
    var folder: FolderHomeViewStore.State = .init()
  }
  
  enum Action {
    case home(HomeViewStore.Action)
    case calendar(CalendarHomeViewStore.Action)
    case folder(FolderHomeViewStore.Action)
    
    case tabSelected(RootTab)
  }
  
  var body: some ReducerOf<Self> {
    Scope(state: \.home, action: \.home) {
      HomeViewStore()
    }
    Scope(state: \.calendar, action: \.calendar) {
      CalendarHomeViewStore()
    }
    Scope(state: \.folder, action: \.folder) {
      FolderHomeViewStore()
    }
    
    Reduce { state, action in
      switch action {
      case .home:
        return .none
        
      case .calendar:
        return .none
        
      case .folder:
        return .none
        
      case let .tabSelected(selectedTab):
        state.selectedTab = selectedTab
        return .none
      }
    }
  }
  
}
