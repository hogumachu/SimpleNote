//
//  AppDelegate.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import SwiftDate

#if os(iOS)
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    appSetup()
    return true
  }
  
}

#elseif os(watchOS)
import WatchKit

class AppDelegate: NSObject, WKApplicationDelegate {
  
  func applicationDidFinishLaunching() {
    appSetup()
  }
  
}
#endif

private extension AppDelegate {
  
  func appSetup() {
    SwiftDate.defaultRegion = .local
  }
  
}
