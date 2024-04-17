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
  
  func hex() -> String {
    let components = UIColor(self).cgColor.components
    let r: CGFloat = components?[0] ?? 0.0
    let g: CGFloat = components?[1] ?? 0.0
    let b: CGFloat = components?[2] ?? 0.0
    let a: CGFloat = {
      if (components?.count ?? 0) < 4 {
        return 1.0
      }
      return components?[3] ?? 1.0
    }()
    
    let hexString = String.init(
      format: "#%02lX%02lX%02lX%02lX",
      lroundf(Float(r * 255)),
      lroundf(Float(g * 255)),
      lroundf(Float(b * 255)),
      lroundf(Float(a * 255))
    )
    return hexString
  }
  
}
