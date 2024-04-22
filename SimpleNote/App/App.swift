//
//  App.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import Entity
import Storage
import SwiftData
import SwiftUI
import ThirdPartyKit

@main
struct SimpleNoteApp: App {
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  @Dependency(\.database) var database
  
  var body: some Scene {
    WindowGroup {
      RootView(store: Store(
        initialState: RootViewStore.State(),
        reducer: { RootViewStore() }
      ))
    }
    .modelContext(try! database.context())
  }
  
}
