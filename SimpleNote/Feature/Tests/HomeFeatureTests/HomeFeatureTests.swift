//
//  HomeFeatureTests.swift
//
//
//  Created by 홍성준 on 5/11/24.
//

import HomeFeature
import SwiftData
import UIFeatureKit
import XCTest

final class HomeFeatureTests: XCTestCase {
  
  private var context: ModelContext?
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    let schema = Schema([Todo.self])
    let configuation = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    let container: ModelContainer = try ModelContainer(for: schema, configurations: configuation)
    context = ModelContext(container)
  }
  
  @MainActor
  func test_search를_누르면_search로_라우팅한다() async {
    let store = TestStore(initialState: HomeViewStore.State()) {
      HomeViewStore()
    }
    
    await store.send(.searchTapped) {
      $0.path = StackState([.search(.init())])
    }
  }
  
  @MainActor
  func test_todo를_누르면_todoDetail로_라우팅한다() async {
    let todo = Todo(id: .init(), todo: "Todo", targetDate: .now, isComplete: false)
    let store = TestStore(initialState: HomeViewStore.State()) {
      HomeViewStore()
    }
    
    await store.send(.todoTapped(todo)) {
      $0.todoDetail = .init(todo: todo)
    }
  }
  
  @MainActor
  func test_check를_누르면_todo의_isComplete_상태를_토글한다() async {
    let todo1 = Todo(id: .init(), todo: "Todo1", targetDate: .now, isComplete: false)
    let todo2 = Todo(id: .init(), todo: "Todo2", targetDate: .now, isComplete: true)
    let store = TestStore(initialState: HomeViewStore.State()) {
      HomeViewStore()
    }
    
    await store.send(.checkTapped(todo1))
    await store.send(.checkTapped(todo2))
    
    XCTAssertEqual(todo1.isComplete, true)
    XCTAssertEqual(todo2.isComplete, false)
  }
  
  @MainActor
  func test_create를_누르면_todoCreate로_라우팅한다() async throws {
    let now = Date(timeIntervalSince1970: 1_234_567_890)
    let store = TestStore(initialState: HomeViewStore.State()) {
      HomeViewStore()
    } withDependencies: {
      $0.date.now = now
    }
    
    await store.send(.createTapped) {
      $0.todoCreate = .init(todo: "", targetDate: now, folder: nil)
    }
  }
  
  @MainActor
  func test_setting을_누르면_setting로_라우팅한다() async throws {
    let store = TestStore(initialState: HomeViewStore.State()) {
      HomeViewStore()
    }
    
    await store.send(.settingTapped) {
      $0.path = StackState([.setting(.init())])
    }
  }
  
}
