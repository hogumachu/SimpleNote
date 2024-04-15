//
//  RootTab.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import Foundation

enum RootTab {
  case home
  
  var title: String {
    switch self {
    case .home: return "Home"
    }
  }
  
  var image: String {
    switch self {
    case .home: return "house"
    }
  }
  
}
