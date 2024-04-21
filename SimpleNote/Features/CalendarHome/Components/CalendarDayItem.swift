//
//  CalendarDayItem.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import Foundation

struct CalendarDayItem: Equatable, Hashable {
  let date: Date
  let isSelected: Bool
  let isLastItem: Bool
}
