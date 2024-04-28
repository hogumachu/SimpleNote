//
//  WatchHomeViewStore.swift
//
//
//  Created by 홍성준 on 4/28/24.
//

import SwiftUI
import WatchFeatureKit

@Reducer
public struct WatchHomeViewStore {
  
  public struct State: Equatable {
    
    public init() {}
  }
  
  public enum Action {
    
  }
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      return .none
    }
  }
  
}
