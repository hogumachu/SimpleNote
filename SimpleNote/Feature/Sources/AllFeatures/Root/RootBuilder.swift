//
//  RootBuilder.swift
//
//
//  Created by 홍성준 on 4/22/24.
//

import SwiftUI
import UIFeatureKit

/// 현재 Feature에 모듈화 진행이 미흡한 상황이라 생성한 빌더
/// 추후 모듈화되면서 제거할 예정
public struct RootBuilder {
  public static func build() -> some View {
    return RootView(store: Store(
      initialState: RootViewStore.State(),
      reducer: { RootViewStore() }
    ))
  }
}
