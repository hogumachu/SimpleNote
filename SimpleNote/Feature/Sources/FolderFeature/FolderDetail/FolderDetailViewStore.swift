//
//  FolderDetailViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import Foundation
import TodoFeature
import UIFeatureKit

@Reducer
public struct FolderDetailViewStore {
  
  @ObservableState
  public struct State: Equatable {
    @Presents public var todoCreate: TodoCreateViewStore.State?
    @Presents public var folderEdit: FolderEditViewStore.State?
    @Presents public var todoDetail: TodoDetailViewStore.State?
    
    public var folder: Folder?
    
    public init(folder: Folder?) {
      self.folder = folder
    }
  }
  
  public enum Action {
    case closeTapped
    case editTapped
    case createTapped
    case checkTapped(Todo)
    case todoTapped(Todo)
    case deleteTapped(Todo)
    case todoCreate(PresentationAction<TodoCreateViewStore.Action>)
    case folderEdit(PresentationAction<FolderEditViewStore.Action>)
    case todoDetail(PresentationAction<TodoDetailViewStore.Action>)
  }
  
  @Dependency(\.dismiss) private var dismiss
  @Dependency(\.todoDatabase) private var todoDatabase
  @Dependency(\.folderDatabase) private var folderDatabase
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .closeTapped:
        return .run { send in
          await dismiss()
        }
        
      case .editTapped:
        if let folder = state.folder {
          state.folderEdit = .init(folder: folder)
        }
        return .none
        
      case .createTapped:
        state.todoCreate = .init(
          todo: "",
          targetDate: .now,
          folder: state.folder
        )
        return .none
        
      case let .checkTapped(todo):
        todo.isComplete?.toggle()
        return .none
        
      case let .todoTapped(todo):
        state.todoDetail = .init(todo: todo)
        return .none
        
      case let .deleteTapped(todo):
        do {
          state.folder?.todos?.removeAll(where: { $0 == todo })
          try todoDatabase.delete(todo)
        } catch {
          
        }
        return .none
        
      case .todoCreate:
        return .none
        
      case let .folderEdit(.presented(.delegate(.edit(title, hexColor)))):
        state.folder?.title = title
        state.folder?.hexColor = hexColor
        state.folderEdit = nil
        return .none
        
      case let .folderEdit(.presented(.delegate(.delete(folder)))):
        state.folderEdit = nil
        
        return .run { send in
          try folderDatabase.delete(folder)
          await dismiss()
        }
      case .folderEdit:
        return .none
        
      case .todoDetail:
        return .none
      }
    }
    .ifLet(\.$todoCreate, action: \.todoCreate) {
      TodoCreateViewStore()
    }
    .ifLet(\.$folderEdit, action: \.folderEdit) {
      FolderEditViewStore()
    }
    .ifLet(\.$todoDetail, action: \.todoDetail) {
      TodoDetailViewStore()
    }
  }
  
}
