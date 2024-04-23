//
//  AppBundle.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/20/24.
//

import Foundation

public enum AppBundle {
  
  public static var appVersion: String {
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    return version ?? ""
  }
  
}
