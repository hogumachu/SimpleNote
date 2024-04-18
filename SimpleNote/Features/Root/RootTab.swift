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
  
  var image: Image {
    switch self {
    case .home: 
      return Image(.house)
        .renderingMode(.template)
      
    case .folder:
      return Image(.folders)
        .renderingMode(.template)
    }
  }
  
  var selectedImage: Image {
    switch self {
    case .home:
      return Image(.houseFill)
        .renderingMode(.template)
      
    case .folder:
      return Image(.foldersFill)
        .renderingMode(.template)
    }
  }
  
  func tabItem(isSelected: Bool) -> some View {
    return Label(
      title: { Text(title) },
      icon: { isSelected ? selectedImage : image }
    )
  }
  
}
