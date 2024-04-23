//
//  SettingBuilder+Imp.swift
//
//
//  Created by 홍성준 on 4/23/24.
//

import Foundation
import SettingFeature
import UIFeatureKit

extension SettingReducer {
  
  public static var implement = SettingReducer(
    build: {
      @Dependency(\.folderDatabase) var folderDatabase
      @Dependency(\.todoDatabase) var todoDatabase
      @Dependency(\.dismiss) var dismiss
      let reducer = Reduce<SettingViewStore.State, SettingViewStore.Action> { state,action in
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
      
      func makeDeleteAlert() -> AlertState<SettingViewStore.Alert> {
        return AlertState {
          TextState("Delete all data", bundle: .setting)
        } actions: {
          ButtonState(role: .cancel) {
            TextState("Cancel", bundle: .setting)
          }
          ButtonState(role: .destructive, action: .confirmDeletion) {
            TextState("Delete", bundle: .setting)
          }
        } message: {
          TextState("Data once deleted cannot be recovered", bundle: .setting)
        }
      }
      
      return reducer
    }
  )
  
}
