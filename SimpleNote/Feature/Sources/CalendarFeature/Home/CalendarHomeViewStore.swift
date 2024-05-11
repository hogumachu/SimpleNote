//
//  CalendarHomeViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/18/24.
//

import Foundation
import SwiftData
import TodoFeature
import UIFeatureKit

@Reducer
public struct CalendarHomeViewStore {
  
  @ObservableState
  public struct State: Equatable {
    public var focusDate: Date
    public var title: String
    public var dayItems: [CalendarDayItem]
    public var isToday: Bool
    @Presents public var todoDetail: TodoDetailViewStore.State?
    @Presents public var todoCreate: TodoCreateViewStore.State?
    
    public init(focusDate: Date = .now) {
      self.focusDate = focusDate
      self.title = ""
      self.dayItems = []
      self.isToday = focusDate.compare(.isSameDay(Date.now))
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case onAppeared
    case dateTapped(Date)
    case checkTapped(Todo)
    case todoTapped(Todo)
    case createTapped
    case todayTapped
    case todoDetail(PresentationAction<TodoDetailViewStore.Action>)
    case todoCreate(PresentationAction<TodoCreateViewStore.Action>)
  }
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding(\.focusDate):
        state.dayItems = makeDayItems(selectedDate: state.focusDate)
        state.title = makeTitle(selectedDate: state.focusDate)
        state.isToday = state.focusDate.compare(.isSameDay(Date.now))
        return .none
        
      case .binding:
        return .none
        
      case .onAppeared:
        state.dayItems = makeDayItems(selectedDate: state.focusDate)
        state.title = makeTitle(selectedDate: state.focusDate)
        return .none
        
      case let .dateTapped(selectedDate):
        @Dependency(\.date.now) var now
        state.focusDate = selectedDate
        state.dayItems = makeDayItems(selectedDate: selectedDate)
        state.title = makeTitle(selectedDate: selectedDate)
        state.isToday = selectedDate.compare(.isSameDay(now))
        return .none
        
      case let .checkTapped(todo):
        todo.isComplete?.toggle()
        return .none
        
      case let .todoTapped(todo):
        state.todoDetail = .init(todo: todo)
        return .none
        
      case .createTapped:
        state.todoCreate = .init(
          todo: "",
          targetDate: state.focusDate,
          folder: nil
        )
        return .none
        
      case .todayTapped:
        @Dependency(\.date.now) var now
        let selectedDate = now
        state.focusDate = selectedDate
        state.dayItems = makeDayItems(selectedDate: selectedDate)
        state.title = makeTitle(selectedDate: selectedDate)
        state.isToday = true
        return .none
        
      case .todoDetail:
        return .none
        
      case .todoCreate:
        return .none
      }
    }
    .ifLet(\.$todoDetail, action: \.todoDetail) {
      TodoDetailViewStore()
    }
    .ifLet(\.$todoCreate, action: \.todoCreate) {
      TodoCreateViewStore()
    }
  }
  
}

private extension CalendarHomeViewStore {
  
  func makeDayItems(selectedDate: Date) -> [CalendarDayItem] {
    return  (0..<7).enumerated().map { offset, item in
      let date = selectedDate.dateAt(.startOfWeek) + item.days
      return .init(
        date: date,
        isSelected: date.compare(.isSameDay(selectedDate)),
        isLastItem: offset == 6
      )
    }
  }
  
  func makeTitle(selectedDate: Date) -> String {
    let formatter = DateFormatter.yearMonthFormatter
    let title = formatter.string(from: selectedDate)
    return title
  }
  
}
