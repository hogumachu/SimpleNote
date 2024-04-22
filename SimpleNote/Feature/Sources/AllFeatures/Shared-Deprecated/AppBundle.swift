//
//  AppBundle.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/20/24.
//

import Foundation

enum AppBundle {
  
  static var appVersion: String {
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    return version ?? ""
  }
  
}
