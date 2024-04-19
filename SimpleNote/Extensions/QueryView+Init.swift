//
//  QueryView+Init.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import SwiftData
import SwiftUI

extension QueryView where T == Todo {
  
  init(
    isSameDayAs date: Date,
    @ViewBuilder content: @escaping ([T]) -> Content
  ) {
    let predicate: Predicate = Todo.predicate(isSameDayAs: date)
    self.init(descriptor: .init(predicate: predicate), content: content)
  }
  
}
