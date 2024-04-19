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
        
        QueryView(isSameDayAs: store.focusDate) { todos in
          if todos.isEmpty {
            Spacer()
            
            EmptyView(subtitle: "There is nothing todo")
            
            Spacer()
          } else {
            ScrollView {
              todoListView(todos)
                .padding(20)
            }
          }
        }
      }
      .background(.background)
      .frame(maxHeight: .infinity, alignment: .top)
      
      createView
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .safeAreaPadding(.bottom, 20)
        .safeAreaPadding(.trailing, 20)
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
  
  var createView: some View {
    Button {
      store.send(.createTapped)
    } label: {
      Image(.plusCircleFill)
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(width: 50, height: 50)
    }
    .foregroundStyle(.foreground)
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
