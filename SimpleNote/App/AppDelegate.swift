//
//  AppDelegate.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import UIKit
import SwiftDate

class AppDelegate: NSObject, UIApplicationDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    appSetup()
    return true
  }
  
}

private extension AppDelegate {
  
  func appSetup() {
    SwiftDate.defaultRegion = .local
    CompositionRoot.assemble()
  }
  
}
