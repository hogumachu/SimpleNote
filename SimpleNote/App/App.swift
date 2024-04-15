//
//  App.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

@main
struct SimpleNoteApp: App {
  @Dependency(\.database) var database
  
  var context: ModelContext {
    do {
      return try database.context()
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }
  
  var body: some Scene {
    WindowGroup {
      AppView(store: .init(initialState: AppStore.State(), reducer: {
        AppStore()
      }))
    }
    .modelContext(context)
  }
  
}
