//
//  SwiftData+Preview.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/17/24.
//

import SwiftData

#if DEBUG
extension ModelContainer {
  
  static func preview() -> ModelContainer {
    do {
      let schema = Schema([
        Folder.self,
        Todo.self
      ])
      let configuration = ModelConfiguration(
        schema: schema,
        isStoredInMemoryOnly: true
      )
      let container = try ModelContainer(
        for: schema,
        configurations: [configuration]
      )
      return container
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }
  
}
#endif
