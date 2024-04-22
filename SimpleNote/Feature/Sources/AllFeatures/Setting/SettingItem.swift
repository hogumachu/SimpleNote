//
//  SettingItem.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/20/24.
//

import FeatureKit
import SwiftUI

enum SettingItem: Equatable, Identifiable {
  
  var id: Int { hashValue }
  
  case hideCompleteTodo
  case version
  case deleteAll
  
  var title: String {
    switch self {
    case .hideCompleteTodo:
      return LocalString("Hiding completed todos", bundle: .module)
      
    case .version:
      return LocalString("App Version", bundle: .module)
      
    case .deleteAll:
      return LocalString("Delete all data", bundle: .module)
    }
  }
  
}
