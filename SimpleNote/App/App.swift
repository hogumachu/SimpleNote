//
//  App.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import AllFeatures
import BaseFeature
import SwiftData
import SwiftUI

@main
struct SimpleNoteApp: App {
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  @Dependency(\.database) var database
  
  var body: some Scene {
    WindowGroup {
      RootBuilder.build()
    }
    .modelContext(try! database.context())
  }
  
}
