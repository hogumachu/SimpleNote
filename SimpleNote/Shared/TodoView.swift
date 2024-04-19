//
//  TodoView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

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
          Image(.folderFill)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(width: 20, height: 20)
            .foregroundStyle(Color(hex: todo.folder?.hexColor ?? "#9f9f9f"))
          
          Text(todo.folder?.title ?? "Empty Folder")
            .font(.callout)
            .foregroundStyle(Color(hex: todo.folder?.hexColor ?? "#9f9f9f"))
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
        Image(todo.isComplete.orFalse ? .checkCircleFill : .circle)
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
