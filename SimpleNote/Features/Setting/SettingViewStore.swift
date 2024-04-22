//
//  SettingViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/20/24.
//

import Entity
import Foundation
import ThirdPartyKit

@Reducer
struct SettingViewStore {
  
  @CasePathable
  enum Alert {
    case confirmDeletion
    case cancel
  }
  
  @ObservableState
  struct State: Equatable {
    @Presents var alert: AlertState<Alert>?
    var settingItems: [SettingItem]
    var appVersion: String
    
    init(
      settingItems: [SettingItem] = [],
      appVersion: String = ""
    ) {
      self.settingItems = settingItems
      self.appVersion = appVersion
    }
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case alert(PresentationAction<Alert>)
    
    case onAppear
    case closeTapped
    case deleteAllTapped
  }
  
  @Dependency(\.folderDatabase) private var folderDatabase
  @Dependency(\.todoDatabase) private var todoDatabase
  @Dependency(\.dismiss) private var dismiss
  
  var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .alert(.presented(.confirmDeletion)):
        return .run { send in
          try folderDatabase.deleteAll()
          try todoDatabase.deleteAll()
          await dismiss()
        }
        
      case .alert:
        return .none
        
      case .onAppear:
        state.settingItems = [
          .hideCompleteTodo,
          .version,
          .deleteAll
        ]
        state.appVersion = AppBundle.appVersion
        return .none
        
      case .closeTapped:
        return .run { send in
          await dismiss()
        }
        
      case .deleteAllTapped:
        state.alert = makeDeleteAlert()
        return .none
      }
    }
  }
  
}

private extension SettingViewStore {
  
  func makeDeleteAlert() -> AlertState<Alert> {
    return AlertState {
      TextState("Delete all data")
    } actions: {
      ButtonState(role: .cancel) {
        TextState("Cancel")
      }
      ButtonState(role: .destructive, action: .confirmDeletion) {
        TextState("Delete")
      }
    } message: {
      TextState("Data once deleted cannot be recovered")
    }
  }
  
}
