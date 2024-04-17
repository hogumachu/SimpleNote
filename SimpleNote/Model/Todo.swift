//
//  Todo.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import Foundation
import SwiftData

@Model
final class Todo {
  
  @Attribute(.unique) var id: UUID
  var todo: String
  var targetDate: Date
  var isComplete: Bool
  
  var folder: Folder?
  
  init(id: UUID, todo: String, targetDate: Date, isComplete: Bool) {
    self.id = id
    self.todo = todo
    self.targetDate = targetDate
    self.isComplete = isComplete
  }
  
}
