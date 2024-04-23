//
//  CalendarDayItem.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import Foundation

public struct CalendarDayItem: Equatable, Hashable {
  public let date: Date
  public let isSelected: Bool
  public let isLastItem: Bool
  
  public init(date: Date, isSelected: Bool, isLastItem: Bool) {
    self.date = date
    self.isSelected = isSelected
    self.isLastItem = isLastItem
  }
}
