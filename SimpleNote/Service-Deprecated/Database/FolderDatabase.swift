//
//  FolderDatabase.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import Entity
import Dependencies
import Foundation
import SwiftData

struct FolderDatabase {
  var fetchAll: @Sendable () throws -> [Folder]
  var fetch: @Sendable (FetchDescriptor<Folder>) throws -> [Folder]
  var add: @Sendable (Folder) throws -> Void
  var delete: @Sendable (Folder) throws -> Void
  var deleteAll: @Sendable () throws -> Void
}

extension FolderDatabase: DependencyKey {
  static let liveValue = FolderDatabase(
    fetchAll: {
      @Dependency(\.database.context) var context
      let folderContext = try context()
      let descriptor = FetchDescriptor<Folder>()
      return try folderContext.fetch(descriptor)
    },
    fetch: { descriptor in
      @Dependency(\.database.context) var context
      let folderContext = try context()
      return try folderContext.fetch(descriptor)
    },
    add: { folder in
      @Dependency(\.database.context) var context
      let folderContext = try context()
      folderContext.insert(folder)
    },
    delete: { folder in
      @Dependency(\.database.context) var context
      let folderContext = try context()
      
      /// CloudKit을 사용하면 cascade가 제대로 동작하지 않음
      /// 따라서 폴더 제거할 때 내부에 있는 Todo를 모두 제거
      folder.todos?.forEach {
        folderContext.delete($0)
      }
      folderContext.delete(folder)
    },
    deleteAll: {
      @Dependency(\.database.context) var context
      let folderContext = try context()
      try folderContext.delete(model: Folder.self)
    }
  )
}

extension DependencyValues {
  var folderDatabase: FolderDatabase {
    get { self[FolderDatabase.self] }
    set { self[FolderDatabase.self] = newValue }
  }
}

