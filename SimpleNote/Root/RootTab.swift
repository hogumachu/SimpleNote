//
//  RootTab.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import SwiftUI
import UIFeatureKit

enum RootTab {
  case home
  case calendar
  case folder
  
  var title: String {
    switch self {
    case .home: return LocalString("Home", bundle: .main)
    case .calendar: return LocalString("Calendar", bundle: .main)
    case .folder: return LocalString("Folder", bundle: .main)
    }
  }
  
  var image: Image {
    switch self {
    case .home: 
      return Image(.House)
        .renderingMode(.template)
      
    case .calendar:
      return Image(.CalendarDots)
        .renderingMode(.template)
      
    case .folder:
      return Image(.Folders)
        .renderingMode(.template)
    }
  }
  
  var selectedImage: Image {
    switch self {
    case .home:
      return Image(.HouseFill)
        .renderingMode(.template)
      
    case .calendar:
      return Image(.CalendarDotsFill)
        .renderingMode(.template)
      
    case .folder:
      return Image(.FoldersFill)
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
