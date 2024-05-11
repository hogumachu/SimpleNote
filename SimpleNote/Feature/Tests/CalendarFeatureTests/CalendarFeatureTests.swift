//
//  CalendarFeatureTests.swift
//
//
//  Created by 홍성준 on 5/11/24.
//

import CalendarFeature
import SwiftData
import UIFeatureKit
import XCTest

final class CalendarFeatureTests: XCTestCase {
  
  private var context: ModelContext?
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    let schema = Schema([Todo.self])
    let configuation = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    let container: ModelContainer = try ModelContainer(for: schema, configurations: configuation)
    context = ModelContext(container)
  }
  
  @MainActor
  func test_onAppeard되면_focustDate를_선택한_CalendarDayItem로_변경한다() async {
    let focusDate = Date(timeIntervalSince1970: 1_234_567)
    let store = TestStore(initialState: CalendarHomeViewStore.State(focusDate: focusDate)) {
      CalendarHomeViewStore()
    }
    
    await store.send(.onAppeared) {
      $0.dayItems = self.makeDayItems(selectedDate: focusDate)
      $0.title = self.makeYearMonthTitle(date: focusDate)
    }
  }
  
  @MainActor
  func test_date를_선택하면_선택한_날짜로_상태를_변경한다() async {
    let focusDate = Date(timeIntervalSince1970: 1_234_567)
    let selectedDate = Date(timeIntervalSince1970: 1_234_567_890)
    let now = Date(timeIntervalSince1970: 0)
    let store = TestStore(initialState: CalendarHomeViewStore.State(focusDate: focusDate)) {
      CalendarHomeViewStore()
    } withDependencies: {
      $0.date.now = now
    }
    
    await store.send(.dateTapped(selectedDate)) {
      $0.focusDate = selectedDate
      $0.dayItems = self.makeDayItems(selectedDate: selectedDate)
      $0.isToday = selectedDate.compare(.isSameDay(now))
      $0.title = self.makeYearMonthTitle(date: selectedDate)
    }
  }
  
  @MainActor
  func test_check를_누르면_todo의_isComplete_상태를_토글한다() async {
    let focusDate = Date(timeIntervalSince1970: 1_234_567)
    let todo1 = Todo(id: .init(), todo: "Todo1", targetDate: .now, isComplete: false)
    let todo2 = Todo(id: .init(), todo: "Todo2", targetDate: .now, isComplete: true)
    let store = TestStore(initialState: CalendarHomeViewStore.State(focusDate: focusDate)) {
      CalendarHomeViewStore()
    }
    
    await store.send(.checkTapped(todo1))
    await store.send(.checkTapped(todo2))
    
    XCTAssertEqual(todo1.isComplete, true)
    XCTAssertEqual(todo2.isComplete, false)
  }
  
  @MainActor
  func test_todo를_누르면_todoDetail로_라우팅한다() async {
    let focusDate = Date(timeIntervalSince1970: 1_234_567)
    let todo = Todo(id: .init(), todo: "Todo", targetDate: .now, isComplete: false)
    let store = TestStore(initialState: CalendarHomeViewStore.State(focusDate: focusDate)) {
      CalendarHomeViewStore()
    }
    
    await store.send(.todoTapped(todo)) {
      $0.todoDetail = .init(todo: todo)
    }
  }
  
  @MainActor
  func test_create를_누르면_todoCreate로_라우팅한다() async {
    let focusDate = Date(timeIntervalSince1970: 1_234_567)
    let store = TestStore(initialState: CalendarHomeViewStore.State(focusDate: focusDate)) {
      CalendarHomeViewStore()
    }
    
    await store.send(.createTapped) {
      $0.todoCreate = .init(todo: "", targetDate: focusDate, folder: nil)
    }
  }
  
  @MainActor
  func test_today를_누르면_오늘_날짜로_상태를_변경한다() async {
    let focusDate = Date(timeIntervalSince1970: 1_234_567)
    let now = Date(timeIntervalSince1970: 0)
    let store = TestStore(initialState: CalendarHomeViewStore.State(focusDate: focusDate)) {
      CalendarHomeViewStore()
    } withDependencies: {
      $0.date.now = now
    }
    
    await store.send(.todayTapped) {
      $0.focusDate = now
      $0.dayItems = self.makeDayItems(selectedDate: now)
      $0.isToday = true
      $0.title = self.makeYearMonthTitle(date: now)
    }
  }
  
}

private extension CalendarFeatureTests {
  
  // MARK: - Helper
  
  private func makeDayItems(selectedDate: Date) -> [CalendarDayItem] {
    return  (0..<7).enumerated().map { offset, item in
      let date = selectedDate.dateAt(.startOfWeek) + item.days
      return .init(
        date: date,
        isSelected: date.compare(.isSameDay(selectedDate)),
        isLastItem: offset == 6
      )
    }
  }
  
  private func makeYearMonthTitle(date: Date) -> String {
    let formatter = DateFormatter.yearMonthFormatter
    return formatter.string(from: date)
  }
  
}
