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
  
  var id: UUID?
  var title: String?
  var hexColor: String?
  
  @Relationship(deleteRule: .cascade, inverse: \Todo.folder)
  var todos: [Todo]? = []
  
  init(id: UUID, title: String, hexColor: String) {
    self.id = id
    self.title = title
    self.hexColor = hexColor
  }
  
}

extension Folder {
  
  static func predicate(searchText: String) -> Predicate<Folder> {
    return #Predicate {
      searchText.isEmpty && ($0.title ?? "").contains(searchText)
    }
  }
  
  static func totalFolders(context: ModelContext) -> Int {
    (try? context.fetchCount(FetchDescriptor<Folder>())) ?? 0
  }
  
}
