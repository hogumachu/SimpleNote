//
//  Database.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import Entity
import Dependencies
import SwiftData

struct Database {
  var context: () throws -> ModelContext
}

private let appContext: ModelContext = {
  do {
    let schema = Schema([
      Folder.self,
      Todo.self
    ])
    let configuration = ModelConfiguration(
      schema: schema,
      isStoredInMemoryOnly: false,
      cloudKitDatabase: .automatic
    )
    let container = try ModelContainer(
      for: schema,
      configurations: [configuration]
    )
    return ModelContext(container)
  } catch {
    fatalError("Could not create ModelContainer: \(error)")
  }
}()

extension Database: DependencyKey {
  static let liveValue = Database(
    context: { appContext }
  )
}

extension DependencyValues {
  var database: Database {
    get { self[Database.self] }
    set { self[Database.self] = newValue }
  }
}
