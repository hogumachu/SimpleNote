//
//  SettingReducer.swift
//
//
//  Created by 홍성준 on 4/23/24.
//

import UIFeatureKit

public struct SettingReducer {
  public var build: () -> Reduce<SettingViewStore.State, SettingViewStore.Action>
  
  public init(build: @escaping () -> Reduce<SettingViewStore.State, SettingViewStore.Action>) {
    self.build = build
  }
}

extension SettingReducer: DependencyKey {
  public static var liveValue = SettingReducer(
    build: {
      fatalError("SettingBuilder 의존성이 주입되지 않았습니다.")
    }
  )
}

public extension DependencyValues {
  var settingReducer: SettingReducer {
    get { self[SettingReducer.self] }
    set { self[SettingReducer.self] = newValue }
  }
}
