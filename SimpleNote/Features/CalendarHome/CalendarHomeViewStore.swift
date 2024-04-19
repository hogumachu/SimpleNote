//
//  CalendarHomeViewStore.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/18/24.
//

import ComposableArchitecture
import Foundation
import SwiftData
import SwiftDate

@Reducer
struct CalendarHomeViewStore {
  
  @ObservableState
  struct State: Equatable {
    var focusDate: Date
    var title: String
    var dayItems: [CalendarDayItem]
    @Presents var todoDetail: TodoDetailViewStore.State?
    
    init(focusDate: Date = .now) {
      self.focusDate = focusDate
      self.title = ""
      self.dayItems = []
    }
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case onAppeared
    case dateTapped(Date)
    case checkTapped(Todo)
    case todoTapped(Todo)
    case todoDetail(PresentationAction<TodoDetailViewStore.Action>)
  }
  
  var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding(\.focusDate):
        state.dayItems = makeDayItems(selectedDate: state.focusDate)
        state.title = makeTitle(selectedDate: state.focusDate)
        return .none
        
      case .binding:
        return .none
        
      case .onAppeared:
        state.dayItems = makeDayItems(selectedDate: state.focusDate)
        state.title = makeTitle(selectedDate: state.focusDate)
        return .none
        
      case let .dateTapped(selectedDate):
        state.focusDate = selectedDate
        state.dayItems = makeDayItems(selectedDate: selectedDate)
        state.title = makeTitle(selectedDate: selectedDate)
        return .none
        
      case let .checkTapped(todo):
        todo.isComplete?.toggle()
        return .none
        
      case let .todoTapped(todo):
        state.todoDetail = .init(todo: todo)
        return .none
        
      case .todoDetail:
        return .none
      }
    }
    .ifLet(\.$todoDetail, action: \.todoDetail) {
      TodoDetailViewStore()
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
