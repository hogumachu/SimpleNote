//
//  Folder.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import Foundation
import SwiftData

@Model
public final class Folder {
  
  public var id: UUID?
  public var title: String?
  public var hexColor: String?
  
  @Relationship(deleteRule: .cascade, inverse: \Todo.folder)
  public var todos: [Todo]? = []
  
  public init(id: UUID, title: String, hexColor: String) {
    self.id = id
    self.title = title
    self.hexColor = hexColor
  }
  
}

public extension Folder {
  
  static func predicate(searchText: String) -> Predicate<Folder> {
    return #Predicate {
      !searchText.isEmpty && ($0.title?.contains(searchText) ?? false)
    }
  }
  
  static func totalFolders(context: ModelContext) -> Int {
    (try? context.fetchCount(FetchDescriptor<Folder>())) ?? 0
  }
  
}
