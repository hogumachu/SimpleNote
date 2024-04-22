//
//  Formatter.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import Foundation

extension DateFormatter {
  
  static let yearMonthFormatter: DateFormatter = {
    let isKorean = Locale.current.language.languageCode == .korean
    let formatter = DateFormatter()
    formatter.dateFormat = isKorean ? "yyyy년 MMM" : "MMM, yyyy"
    return formatter
  }()
  
}
