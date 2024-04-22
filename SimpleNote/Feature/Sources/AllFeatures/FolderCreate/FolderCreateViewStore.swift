//
//  FolderCreateViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/16/24.
//

import BaseFeature
import SwiftUI

@Reducer
struct FolderCreateViewStore {
  
  @ObservableState
  struct State: Equatable {
    var title: String
    var color: Color
    
    init(title: String, hexColor: String) {
      self.title = title
      self.color = Color(hex: hexColor)
    }
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    
    case createTapped
    case closeTapped
    case colorChangeTapped
    case delegate(Delegate)
    
    enum Delegate {
      case create(Folder)
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  
  var body: some ReducerOf<Self> {
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
