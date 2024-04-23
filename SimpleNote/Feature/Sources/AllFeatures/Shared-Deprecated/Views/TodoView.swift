//
//  TodoView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import Entity
import SwiftUI

struct TodoView: View {
  
  private let todo: Todo
  private var checkTapped: (Todo) -> Void
  private var onTapped: (Todo) -> Void
  
  init(
    todo: Todo,
    checkTapped: @escaping (Todo) -> Void,
    onTapped: @escaping (Todo) -> Void
  ) {
    self.todo = todo
    self.checkTapped = checkTapped
    self.onTapped = onTapped
  }
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        HStack(spacing: 3) {
          Image(.FolderFill)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(width: 20, height: 20)
            .foregroundStyle(Color(hexOrGray: todo.folder?.hexColor))
          
          if let title = todo.folder?.title {
            Text(title)
              .font(.callout)
              .foregroundStyle(Color(hexOrGray: todo.folder?.hexColor))
          } else {
            Text("None", bundle: .module)
              .font(.callout)
              .foregroundStyle(Color(hexOrGray: todo.folder?.hexColor))
          }
        }
        
        Text(todo.todo.orEmpty)
          .font(.body)
          .foregroundStyle(todo.isComplete.orFalse ? .secondary : .primary)
        
        Text("\(todo.targetDate.orNow.formatted(date: .complete, time: .omitted))")
          .font(.caption)
          .foregroundStyle(.secondary)
      }
      
      Spacer()
      
      Button {
        withAnimation {
          checkTapped(todo)
        }
      } label: {
        Image(todo.isComplete.orFalse ? .CheckCircleFill : .Circle)
          .resizable()
          .renderingMode(.template)
          .frame(width: 30, height: 30)
          .foregroundStyle(.foreground)
      }
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 16)
        .foregroundStyle(Color.secondarySystemBackground)
    )
    .onTapGesture {
      onTapped(todo)
    }
  }
}