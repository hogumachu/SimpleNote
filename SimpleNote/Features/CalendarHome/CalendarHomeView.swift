//
//  CalendarHomeView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import ComposableArchitecture
import SwiftData
import SwiftDate
import SwiftUI

struct CalendarHomeView: View {
  
  @Bindable private var store: StoreOf<CalendarHomeViewStore>
  
  @AppStorage(UserDefaultsKey.hideCompleteTodo.rawValue)
  private var hideCompleteTodo = false
  
  init(store: StoreOf<CalendarHomeViewStore>) {
    self.store = store
  }
  
  var body: some View {
    ZStack {
      VStack(spacing: 0) {
        navigationBar
          .padding(.horizontal, 20)
        
        weekView
        
        Divider()
          .padding(.top, 10)
        
        QueryView(isSameDayAs: store.focusDate, hideCompleteTodo: hideCompleteTodo) { todos in
          if todos.isEmpty {
            Spacer()
            
            BoxEmptyView(state: .emptyTodo)
            
            Spacer()
          } else {
            ScrollView {
              todoListView(todos)
                .padding(20)
              
              Spacer()
                .padding(40)
            }
          }
        }
      }
      .background(.background)
      .frame(maxHeight: .infinity, alignment: .top)
      
      HStack {
        if !store.isToday {
          todayView
        }
        
        Spacer()
        
        PlusButton { store.send(.createTapped) }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
      .safeAreaPadding(.bottom, 20)
      .safeAreaPadding(.horizontal, 20)
    }
    .onAppear {
      store.send(.onAppeared)
    }
    .fullScreenCover(item: $store.scope(state: \.todoDetail, action: \.todoDetail)) {
      TodoDetailView(store: $0)
    }
    .fullScreenCover(item: $store.scope(state: \.todoCreate, action: \.todoCreate)) {
      TodoCreateView(store: $0)
    }
  }
}

private extension CalendarHomeView {
  
  var navigationBar: some View {
    HStack {
      Text(store.title)
        .font(.headline)
      
      Spacer()
      
      Image(.calendarDots)
        .resizable()
        .renderingMode(.template)
        .frame(width: 30, height: 30)
        .foregroundStyle(.foreground)
        .overlay {
          DatePicker(
            selection: $store.focusDate,
            displayedComponents: .date
          ) {}
            .labelsHidden()
            .colorInvert()
            .tint(.primary)
            .opacity(0.02)
        }
    }
    .frame(height: 50)
  }
  
  var weekView: some View {
    HStack {
      ForEach(store.dayItems, id: \.self) { item in
        Spacer()
        
        VStack(spacing: 2) {
          Text("\(item.date.weekdayName(.short))")
            .foregroundStyle(.foreground)
            .font(.callout)
          
          Button {
            store.send(.dateTapped(item.date))
          } label: {
            Text("\(item.date.day)")
              .foregroundStyle(item.isSelected ? Color.systemBackground : Color.gray)
          }
          .padding(.all, 10)
          .background(
            Circle()
              .fill(item.isSelected ? Color.primary : Color.systemBackground)
          )
        }
        
        if item.isLastItem {
          Spacer()
        }
      }
    }
    .frame(maxWidth: .infinity)
  }
  
  func todoListView(_ todos: [Todo]) -> some View {
    LazyVStack {
      ForEach(todos) { todo in
        TodoView(
          todo: todo,
          checkTapped: { store.send(.checkTapped($0)) },
          onTapped: { store.send(.todoTapped($0)) }
        )
        .frame(maxWidth: .infinity)
      }
    }
  }
  
  var todayView: some View {
    Button {
      store.send(.todayTapped)
    } label: {
      Text("Today")
        .font(.headline)
        .foregroundStyle(.foreground)
      
      Image(.caretRight)
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(width: 20, height: 20)
        .foregroundStyle(.foreground)
    }
    .padding(10)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .foregroundStyle(.background.opacity(0.7))
    )
  }
  
}

#Preview {
  CalendarHomeView(store: Store(
    initialState: CalendarHomeViewStore.State(),
    reducer: {
      CalendarHomeViewStore()
    }
  ))
}
