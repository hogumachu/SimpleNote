//
//  TodoDatabase.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import Entity
import Dependencies
import Foundation
import SwiftData

public struct TodoDatabase {
  public var fetchAll: @Sendable () throws -> [Todo]
  public var fetch: @Sendable (FetchDescriptor<Todo>) throws -> [Todo]
  public var add: @Sendable (Todo) throws -> Void
  public var delete: @Sendable (Todo) throws -> Void
  public var deleteAll: @Sendable () throws -> Void
  
  public init(
    fetchAll: @Sendable @escaping () throws -> [Todo],
    fetch: @Sendable @escaping (FetchDescriptor<Todo>) throws -> [Todo],
    add: @Sendable @escaping (Todo) throws -> Void,
    delete: @Sendable @escaping (Todo) throws -> Void,
    deleteAll: @Sendable @escaping () throws -> Void)
  {
    self.fetchAll = fetchAll
    self.fetch = fetch
    self.add = add
    self.delete = delete
    self.deleteAll = deleteAll
  }
}

extension TodoDatabase: DependencyKey {
  public static let liveValue = TodoDatabase(
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
    },
    deleteAll: {
      @Dependency(\.database.context) var context
      let todoContext = try context()
      try todoContext.delete(model: Todo.self)
    }
  )
}

public extension DependencyValues {
  var todoDatabase: TodoDatabase {
    get { self[TodoDatabase.self] }
    set { self[TodoDatabase.self] = newValue }
  }
}
