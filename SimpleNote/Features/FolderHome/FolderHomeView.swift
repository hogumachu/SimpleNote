//
//  FolderHomeView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import ComposableArchitecture
import SwiftUI
import SwiftData

struct FolderHomeView: View {
  
  @Bindable var store: StoreOf<FolderHomeViewStore>
  
  var body: some View {
    NavigationStack(
      path: $store.scope(state: \.path, action: \.path)
    ) {
      VStack(alignment: .leading) {
        navigationBar
          .padding(.horizontal, 10)
        
        listView
      }
      .frame(maxHeight: .infinity, alignment: .top)
    } destination: {
      FolderDetailView(store: $0)
        .toolbar(.hidden, for: .tabBar)
        .toolbar(.hidden, for: .navigationBar)
    }
    .fullScreenCover(item: $store.scope(state: \.folderCreate, action: \.folderCreate)) {
      FolderCreateView(store: $0)
    }
    .onAppear {
      store.send(.onAppeared)
    }
  }
  
}

private extension FolderHomeView {
  
  var navigationBar: some View {
    HStack {
      Text("Folders")
        .font(.headline)
      
      Spacer()
    }
    .frame(height: 50)
  }
  
  var listView: some View {
    ScrollView {
      LazyVGrid(
        columns: listGridItems(),
        spacing: 10
      ) {
        Button {
          store.send(.addButtonTapped)
        } label: {
          VStack(spacing: 10) {
            Image(systemName: "plus")
              .resizable()
              .frame(width: 30, height: 30)
              .foregroundStyle(Color.blue)
            
            Text("New folder")
              .font(.body)
          }
          .frame(maxWidth: .infinity, minHeight: 100)
          .padding(.horizontal, 20)
          .padding(.vertical, 20)
          .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
              .fill(Color.blue.opacity(0.1))
          )
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        
        ForEach(store.folders) { folder in
          NavigationLink(state: FolderDetailViewStore.State(folder: folder)) {
            HStack {
              VStack(spacing: 10) {
                Circle()
                  .fill(Color(hex: folder.hexColor))
                  .frame(width: 50, height: 50)
                
                VStack(spacing: 0) {
                  Text(folder.title)
                    .font(.body)
                    .foregroundStyle(Color(hex: folder.hexColor))
                  
                  Text("\(folder.todos.count) todos")
                    .font(.caption)
                    .foregroundStyle(Color.gray)
                }
              }
            }
            .frame(maxWidth: .infinity, minHeight: 100)
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background(
              RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(hex: folder.hexColor).opacity(0.1))
            )
          }
          .padding(.horizontal, 10)
          .padding(.vertical, 5)
        }
      }
    }
  }
  
  func listGridItems() -> [GridItem] {
    if UIDevice.current.isPhone {
      return [GridItem(spacing: 5), GridItem(spacing: 5)]
    } else {
      return [GridItem(spacing: 5), GridItem(spacing: 5), GridItem(spacing: 5)]
    }
  }
  
}

#Preview {
  let container = ModelContainer.preview()
  
  return FolderHomeView(
    store: Store(
      initialState: FolderHomeViewStore.State(
        folders: [
          .init(id: .init(), title: "Foloder1", hexColor: "#000000"),
          .init(id: .init(), title: "Foloder2", hexColor: "#3369FF"),
          .init(id: .init(), title: "Foloder3", hexColor: "#1E315F"),
          .init(id: .init(), title: "Foloder4", hexColor: "F05138"),
          .init(id: .init(), title: "Foloder5", hexColor: "00000040"),
          .init(id: .init(), title: "Foloder6", hexColor: "00000050"),
          .init(id: .init(), title: "Foloder7", hexColor: "00000060"),
          .init(id: .init(), title: "Foloder8", hexColor: "00000070"),
          .init(id: .init(), title: "Foloder9", hexColor: "00000080"),
          .init(id: .init(), title: "Foloder10", hexColor: "00000090"),
          .init(id: .init(), title: "Foloder10111123123123123", hexColor: "00000090"),
          .init(id: .init(), title: "Foloder10", hexColor: "00000090"),
          .init(id: .init(), title: "Foloder10", hexColor: "00000090"),
          .init(id: .init(), title: "Foloder10", hexColor: "00000090"),
          .init(id: .init(), title: "Foloder10", hexColor: "00000090"),
          .init(id: .init(), title: "Foloder10", hexColor: "00000090"),
          .init(id: .init(), title: "Foloder10", hexColor: "00000090"),
          .init(id: .init(), title: "Foloder10", hexColor: "00000090"),
        ]
      )
    ) {
      FolderHomeViewStore()
    }
  )
  .modelContainer(container)
}
