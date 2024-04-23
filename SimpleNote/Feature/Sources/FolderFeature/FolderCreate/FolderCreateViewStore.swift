//
//  FolderCreateViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/16/24.
//

import SwiftUI
import UIFeatureKit

@Reducer
public struct FolderCreateViewStore {
  
  @ObservableState
  public struct State: Equatable {
    public var title: String
    public var color: Color
    
    public init(title: String, hexColor: String) {
      self.title = title
      self.color = Color(hex: hexColor)
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    
    case createTapped
    case closeTapped
    case colorChangeTapped
    case delegate(Delegate)
    
    public enum Delegate {
      case create(Folder)
    }
  }
  
  @Dependency(\.dismiss) private var dismiss
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .createTapped:
        return .run { [
          title = state.title,
          color = state.color
        ] send in
          let folder = Folder(id: .init(), title: title, hexColor: color.hex())
          await send(.delegate(.create(folder)))
          await dismiss()
        }
        
      case .closeTapped:
        return .run { _ in
          await dismiss()
        }
        
      case .colorChangeTapped:
        return .none
        
      case .delegate:
        return .none
      }
    }
  }
  
}
