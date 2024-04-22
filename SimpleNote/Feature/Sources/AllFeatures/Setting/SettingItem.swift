//
//  SettingItem.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/20/24.
//

import Foundation
import SwiftUI

enum SettingItem: Equatable, Identifiable {
  
  var id: Int { hashValue }
  
  case hideCompleteTodo
  case version
  case deleteAll
  
  var title: LocalizedStringKey {
    switch self {
    case .hideCompleteTodo:
      return .init(stringLiteral: "Hiding completed todos")
      
    case .version:
      return .init(stringLiteral: "App Version")
      
    case .deleteAll:
      return .init(stringLiteral: "Delete all data")
    }
  }
  
}
