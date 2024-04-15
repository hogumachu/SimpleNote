//
//  Folder.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import Foundation
import SwiftData

@Model
final class Folder {
  
  @Attribute(.unique) var id: UUID
  var title: String
  var hexColor: String
  
  @Relationship(deleteRule: .cascade)
  var todos: [Todo] = []
  
  init(id: UUID, title: String, hexColor: String) {
    self.id = id
    self.title = title
    self.hexColor = hexColor
  }
  
}