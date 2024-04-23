//
//  FolderEditViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/18/24.
//

import SwiftUI
import UIFeatureKit

@Reducer
public struct FolderEditViewStore {
  
  @ObservableState
  public struct State: Equatable {
    @Presents public var alert: AlertState<Action.Alert>?
    public let folder: Folder
    public var title: String
    public var color: Color
    
    public init(folder: Folder) {
      self.folder = folder
      self.title = folder.title.orEmpty
      self.color = Color(hexOrGray: folder.hexColor)
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    
    case alert(PresentationAction<Alert>)
    
    case deleteTapped
    case editTapped
    case closeTapped
    
    case delegate(Delegate)
    
    @CasePathable
    public enum Alert {
      case confirmDeletion
      case cancel
    }
    
    public enum Delegate {
      case edit(title: String, hexColor: String)
      case delete(Folder)
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
        
      case .alert(.presented(.confirmDeletion)):
        return .run { [folder = state.folder] send in
          await send(.delegate(.delete(folder)))
          await dismiss()
        }
        
      case .alert:
        return .none
        
      case .deleteTapped:
        state.alert = AlertState {
          TextState("Delete folder")
        } actions: {
          ButtonState(role: .cancel) {
            TextState("Cancel")
          }
          ButtonState(role: .destructive, action: .confirmDeletion) {
            TextState("Delete")
          }
        } message: {
          TextState("If you delete the folder, the data inside will be erased together.")
        }
        return .none
        
      case .editTapped:
        return .run { [
          title = state.title,
          color = state.color
        ] send in
          await send(.delegate(.edit(title: title, hexColor: color.hex())))
        }
        
      case .closeTapped:
        return .run { _ in
          await dismiss()
        }
        
      case .delegate:
        return .none
      }
    }
    .ifLet(\.$alert, action: \.alert)
  }
  
}
