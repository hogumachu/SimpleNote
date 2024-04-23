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
  
  @Dependency(\.settingReducer) private var reducer
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer.build()
  }
  
}
