//
//  Color+.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/18/24.
//

import SwiftUI

public extension Color {
  
  #if os(iOS)
  static let systemBackground = Color(uiColor: .systemBackground)
  static let secondarySystemBackground = Color(uiColor: .secondarySystemBackground)
  static let tertiarySystemBackground = Color(uiColor: .tertiarySystemBackground)
  #endif
  
}
