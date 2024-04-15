//
//  RootTab.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import SwiftUI

enum RootTab {
  case home
  case folder
  
  var title: String {
    switch self {
    case .home: return "Home"
    case .folder: return "Folder"
    }
  }
  
  var image: String {
    switch self {
    case .home: return "house"
    case .folder: return "folder"
    }
  }
  
  var tabItem: some View {
    return Label(
      title: { Text(title) },
      icon: { Image(systemName: image) }
    )
  }
  
}
