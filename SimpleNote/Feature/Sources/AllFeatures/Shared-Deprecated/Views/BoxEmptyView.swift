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
  
  var title: LocalizedStringResource {
    switch self {
    case .emptyFolder:
      return .init(stringLiteral: "Empty")
      
    case .emptyFolderWithCreateDescription:
      return .init(stringLiteral: "There is no folder")
      
    case .emptyTodo:
      return .init(stringLiteral: "Empty")
      
    case .emptyTodoForToday:
      return .init(stringLiteral: "Empty")
    }
  }
  
  var subtitle: LocalizedStringResource {
    switch self {
    case .emptyFolder:
      return .init(stringLiteral: "There is no folder")
      
    case .emptyFolderWithCreateDescription:
      return .init(stringLiteral: "You can create folders in the folder tab")
      
    case .emptyTodo:
      return .init(stringLiteral: "There is nothing todo")
      
    case .emptyTodoForToday:
      return .init(stringLiteral: "There are no todos for today")
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
