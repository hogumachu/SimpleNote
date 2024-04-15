//
//  TodoDatabase.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import Dependencies
import Foundation
import SwiftData

struct TodoDatabase {
  var fetchAll: @Sendable () throws -> [Todo]
  var fetch: @Sendable (FetchDescriptor<Todo>) throws -> [Todo]
  var add: @Sendable (Todo) throws -> Void
  var delete: @Sendable (Todo) throws -> Void
}

extension TodoDatabase: DependencyKey {
  static let liveValue = TodoDatabase(
    fetchAll: {
      @Dependency(\.database.context) var context
      let todoContext = try context()
      let descriptor = FetchDescriptor<Todo>()
      return try todoContext.fetch(descriptor)
    },
    fetch: { descriptor in
      @Dependency(\.database.context) var context
      let todoContext = try context()
      return try todoContext.fetch(descriptor)
    },
    add: { todo in
      @Dependency(\.database.context) var context
      let todoContext = try context()
      todoContext.insert(todo)
    },
    delete: { todo in
      @Dependency(\.database.context) var context
      let todoContext = try context()
      todoContext.delete(todo)
    }
  )
}

extension DependencyValues {
  var todoDatabase: TodoDatabase {
    get { self[TodoDatabase.self] }
    set { self[TodoDatabase.self] = newValue }
  }
}
