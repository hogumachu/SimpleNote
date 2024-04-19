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
    VStack(spacing: 0) {
      navigationBar
        .padding(.horizontal, 20)
      
      weekView
      
      Divider()
        .padding(.top, 10)
      
      if store.todos.isEmpty {
        Spacer()
        
        EmptyView(subtitle: "There is nothing todo")
        
        Spacer()
      } else {
        ScrollView {
          todoListView
            .padding(20)
        }
      }
    }
    .background(.background)
    .frame(maxHeight: .infinity, alignment: .top)
    .onAppear {
      store.send(.onAppeared)
    }
    .fullScreenCover(item: $store.scope(state: \.todoDetail, action: \.todoDetail)) {
      TodoDetailView(store: $0)
    }
  }
}

private extension CalendarHomeView {
  
  var navigationBar: some View {
    HStack {
      Text(store.title)
        .font(.headline)
      
      Spacer()
      
      Image(systemName: "calendar")
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
  
  var todoListView: some View {
    LazyVStack {
      ForEach(store.todos) { todo in
        TodoView(
          todo: todo,
          checkTapped: { store.send(.checkTapped($0)) },
          onTapped: { store.send(.todoTapped($0)) }
        )
        .frame(maxWidth: .infinity)
      }
    }
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
