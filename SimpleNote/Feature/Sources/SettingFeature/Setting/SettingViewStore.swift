//
//  SettingViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/20/24.
//

import Foundation
import UIFeatureKit

@Reducer
public struct SettingViewStore {
  
  @CasePathable
  public enum Alert {
    case confirmDeletion
    case cancel
  }
  
  @ObservableState
  public struct State: Equatable {
    @Presents public var alert: AlertState<Alert>?
    public var settingItems: [SettingItem]
    public var appVersion: String
    
    public init(
      settingItems: [SettingItem] = [],
      appVersion: String = ""
    ) {
      self.settingItems = settingItems
      self.appVersion = appVersion
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case alert(PresentationAction<Alert>)
    
    case onAppear
    case closeTapped
    case deleteAllTapped
  }
  
  @Dependency(\.folderDatabase) private var folderDatabase
  @Dependency(\.todoDatabase) private var todoDatabase
  @Dependency(\.dismiss) private var dismiss
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
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
  
  func makeDeleteAlert() -> AlertState<SettingViewStore.Alert> {
    return AlertState {
      TextState("Delete all data", bundle: .module)
    } actions: {
      ButtonState(role: .cancel) {
        TextState("Cancel", bundle: .module)
      }
      ButtonState(role: .destructive, action: .confirmDeletion) {
        TextState("Delete", bundle: .module)
      }
    } message: {
      TextState("Data once deleted cannot be recovered", bundle: .module)
    }
  }
  
}
