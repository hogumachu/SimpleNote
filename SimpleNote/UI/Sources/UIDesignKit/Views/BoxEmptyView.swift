//
//  BoxEmptyView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/18/24.
//

import Lottie
import SwiftUI

public enum EmptyViewState {
  case emptyFolder
  case emptyFolderWithCreateDescription
  case emptyTodo
  case emptyTodoForToday
  
  public var title: String {
    switch self {
    case .emptyFolder:
      return NSLocalizedString("Empty", bundle: .module, comment: "")
      
    case .emptyFolderWithCreateDescription:
      return NSLocalizedString("There is no folder", bundle: .module, comment: "")
      
    case .emptyTodo:
      return NSLocalizedString("Empty", bundle: .module, comment: "")
      
    case .emptyTodoForToday:
      return NSLocalizedString("Empty", bundle: .module, comment: "")
    }
  }
  
  public var subtitle: String {
    switch self {
    case .emptyFolder:
      return NSLocalizedString("There is no folder", bundle: .module, comment: "")
      
    case .emptyFolderWithCreateDescription:
      return NSLocalizedString("You can create folders in the folder tab", bundle: .module, comment: "")
      
    case .emptyTodo:
      return NSLocalizedString("There is nothing todo", bundle: .module, comment: "")
      
    case .emptyTodoForToday:
      return NSLocalizedString("There are no todos for today", bundle: .module, comment: "")
    }
  }
}

public struct BoxEmptyView: View {
  
  private let state: EmptyViewState
  
  public init(state: EmptyViewState) {
    self.state = state
  }
  
  public var body: some View {
    VStack {
      LottieView(animation: .named("empty-box", bundle: .module))
        .playing(loopMode: .playOnce)
        .frame(maxHeight: 250)
      
      Text(state.title)
        .font(.headline)
        .foregroundStyle(.foreground)
      
      Text(state.subtitle)
        .font(.callout)
        .foregroundStyle(.gray)
        .padding(.bottom, 40)
    }
  }
  
}
