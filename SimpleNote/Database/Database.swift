//
//  Database.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import Dependencies
import SwiftData

struct Database {
  var context: () throws -> ModelContext
}

extension Database: DependencyKey {
  static let liveValue = Database(
    context: {
      do {
        let schema = Schema([
          Folder.self,
          Todo.self
        ])
        let configuration = ModelConfiguration(
          schema: schema,
          isStoredInMemoryOnly: false
        )
        let container = try ModelContainer(
          for: schema,
          configurations: [configuration]
        )
        return ModelContext(container)
      } catch {
        throw error
      }
    }
  )
}

extension DependencyValues {
  var database: Database {
    get { self[Database.self] }
    set { self[Database.self] = newValue }
  }
}
