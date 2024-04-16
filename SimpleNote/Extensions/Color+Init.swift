//
//  Color+Init.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/16/24.
//

import SwiftUI

public extension Color {
  
  init(hex: String) {
    let hexSanitized = hex
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .replacingOccurrences(of: "#", with: "")
    
    var rgb: UInt64 = 0
    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0
    var a: CGFloat = 1.0
    
    let length = hexSanitized.count
    
    if Scanner(string: hexSanitized).scanHexInt64(&rgb) == true {
      if length == 6 {
        r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        b = CGFloat(rgb & 0x0000FF) / 255.0
      } else if length == 8 {
        r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
        g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
        b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
        a = CGFloat(rgb & 0x000000FF) / 255.0
      }
    }
    
    self.init(red: r, green: g, blue: b, opacity: a)
  }
  
}
