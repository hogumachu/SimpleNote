//
//  Todo.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import Foundation
import SwiftData
import SwiftDate

@Model
final class Todo {
  
  var id: UUID?
  var todo: String?
  var targetDate: Date?
  var isComplete: Bool?
  
  var folder: Folder?
  
  init(id: UUID, todo: String, targetDate: Date, isComplete: Bool) {
    self.id = id
    self.todo = todo
    self.targetDate = targetDate
    self.isComplete = isComplete
  }
  
}

extension Todo {
  
  static func predicate(searchText: String) -> Predicate<Todo> {
    return #Predicate {
      !searchText.isEmpty && ($0.todo?.contains(searchText) ?? false)
    }
  }
  
  static func predicate(isSameDayAs date: Date, hideCompleteTodo: Bool) -> Predicate<Todo> {
    let calendar = Calendar.autoupdatingCurrent
    let start = calendar.startOfDay(for: date)
    let end = calendar.date(byAdding: .day, value: 1, to: start) ?? start
    let now = Date.now
    return #Predicate {
      if hideCompleteTodo {
        return !($0.isComplete ?? true) && $0.targetDate ?? now >= start && $0.targetDate ?? now < end
      } else {
        return $0.targetDate ?? now >= start && $0.targetDate ?? now < end
      }
    }
  }
  
  static func predicate(folderID: UUID?) -> Predicate<Todo> {
    return #Predicate {
      $0.folder?.id == folderID
    }
  }
  
  static func predicate(lessThan date: Date, isComplete: Bool = false) -> Predicate<Todo> {
    let calendar = Calendar.autoupdatingCurrent
    let start = calendar.startOfDay(for: date)
    let now = Date.now
    return #Predicate {
      $0.targetDate ?? now < start && $0.isComplete ?? false == isComplete
    }
  }
  
  static func predicate(
    greaterThanEqaul greaterDate: Date,
    lessThan lessDate: Date,
    hideCompleteTodo: Bool
  ) -> Predicate<Todo> {
    let calendar = Calendar.autoupdatingCurrent
    let start = calendar.startOfDay(for: greaterDate)
    let end = calendar.startOfDay(
      for: calendar.date(byAdding: .day, value: 1, to: lessDate) ?? lessDate
    )
    let now = Date.now
    return #Predicate {
      if hideCompleteTodo {
        return !($0.isComplete ?? true) && $0.targetDate ?? now >= start && $0.targetDate ?? now < end
      } else {
        return $0.targetDate ?? now >= start && $0.targetDate ?? now < end
      }
    }
  }
  
}
