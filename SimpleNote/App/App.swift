//
//  App.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import SwiftData
import SwiftUI

#if os(iOS)
import UIFeatureKit
#elseif os(watchOS)
import WatchFeatureKit
import WatchHomeFeature
#endif

@main
struct SimpleNoteApp: App {
  
#if os(iOS)
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
#elseif os(watchOS)
  @WKApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
#endif
  @Dependency(\.database) var database
  
  var body: some Scene {
    WindowGroup {
#if os(iOS)
      RootView(store: Store(
        initialState: RootViewStore.State(),
        reducer: { RootViewStore() }
      ))
#elseif os(watchOS)
      WatchHomeView(store: Store(
        initialState: WatchHomeViewStore.State(),
        reducer: { WatchHomeViewStore() }
      ))
#endif
    }
    .modelContext(try! database.context())
  }
  
}
