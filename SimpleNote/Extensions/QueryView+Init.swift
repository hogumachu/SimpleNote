//
//  QueryView+Init.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import Entity
import SwiftData
import SwiftUI

extension QueryView where T == Todo {
  
  init(
    lessThan date: Date,
    @ViewBuilder content: @escaping ([T]) -> Content
  ) {
    let predicate: Predicate = Todo.predicate(lessThan: date)
    self.init(descriptor: .init(predicate: predicate), content: content)
  }
  
  init(
    greaterThanEqaul greaterDate: Date,
    lessThan lessDate: Date,
    hideCompleteTodo: Bool,
    @ViewBuilder content: @escaping ([T]) -> Content
  ) {
    let predicate: Predicate = Todo.predicate(
      greaterThanEqaul: greaterDate,
      lessThan: lessDate,
      hideCompleteTodo: hideCompleteTodo
    )
    self.init(
      descriptor: .init(
        predicate: predicate,
        sortBy: [.init(\.targetDate)]
      ),
      content: content
    )
  }
  
  init(
    isSameDayAs date: Date,
    hideCompleteTodo: Bool,
    @ViewBuilder content: @escaping ([T]) -> Content
  ) {
    let predicate: Predicate = Todo.predicate(isSameDayAs: date, hideCompleteTodo: hideCompleteTodo)
    self.init(descriptor: .init(predicate: predicate), content: content)
  }
  
  init(
    searchText: String,
    @ViewBuilder content: @escaping ([T]) -> Content
  ) {
    let predicate: Predicate = Todo.predicate(searchText: searchText)
    self.init(descriptor: .init(predicate: predicate), content: content)
  }
  
}

extension QueryView where T == Folder {
  
  init(
    searchText: String,
    @ViewBuilder content: @escaping ([T]) -> Content
  ) {
    let predicate: Predicate = Folder.predicate(searchText: searchText)
    self.init(descriptor: .init(predicate: predicate), content: content)
  }
  
}
