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
  
  private let database: Database
  private let context: ModelContext
  
  /// SwiftData의 Context는 initialize에서 설정해야 함
  /// ref: https://forums.developer.apple.com/forums/thread/734212
  init() {
    self.database = .liveValue
    do {
      self.context = try database.context()
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }
  
  var body: some Scene {
    WindowGroup {
      AppView(store: Store(initialState: AppStore.State()) {
        AppStore()
      })
    }
    .modelContext(context)
  }
  
}
