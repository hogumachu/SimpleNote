//
//  BoxEmptyView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/18/24.
//

import BaseFeature
import Lottie
import SwiftUI

enum EmptyViewState {
  case emptyFolder
  case emptyFolderWithCreateDescription
  case emptyTodo
  case emptyTodoForToday
  
  var title: String {
    switch self {
    case .emptyFolder:
      return LocalString("Empty", bundle: .module)
      
    case .emptyFolderWithCreateDescription:
      return LocalString("There is no folder", bundle: .module)
      
    case .emptyTodo:
      return LocalString("Empty", bundle: .module)
      
    case .emptyTodoForToday:
      return LocalString("Empty", bundle: .module)
    }
  }
  
  var subtitle: String {
    switch self {
    case .emptyFolder:
      return LocalString("There is no folder", bundle: .module)
      
    case .emptyFolderWithCreateDescription:
      return LocalString("You can create folders in the folder tab", bundle: .module)
      
    case .emptyTodo:
      return LocalString("There is nothing todo", bundle: .module)
      
    case .emptyTodoForToday:
      return LocalString("There are no todos for today", bundle: .module)
    }
  }
}

struct BoxEmptyView: View {
  
  private let state: EmptyViewState
  
  init(state: EmptyViewState) {
    self.state = state
  }
  
  var body: some View {
    VStack {
      LottieView(animation: .named("empty-box", bundle: .base))
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
