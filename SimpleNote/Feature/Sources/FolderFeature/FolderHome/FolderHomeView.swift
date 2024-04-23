//
//  FolderHomeView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import SwiftData
import SwiftUI
import UIFeatureKit

public struct FolderHomeView: View {
  
  @Bindable private var store: StoreOf<FolderHomeViewStore>
  @Query private var folders: [Folder]
  @Query private var emptyFolderTodos: [Todo]
  
  public init(store: StoreOf<FolderHomeViewStore>) {
    self.store = store
    self._folders = Query()
    self._emptyFolderTodos = Query(filter: Todo.predicate(folderID: nil))
  }
  
  public var body: some View {
    NavigationStack(
      path: $store.scope(state: \.path, action: \.path)
    ) {
      VStack(alignment: .leading, spacing: 0) {
        NavigationBar(style: .titleOnly(LocalString("Folder", bundle: .module)))
          .padding(.horizontal, 20)
        
        Divider()
          .padding(.top, 10)
        
        listView
          .padding(.horizontal, 20)
      }
      .frame(maxHeight: .infinity, alignment: .top)
    } destination: {
      FolderDetailView(store: $0)
        .toolbar(.hidden, for: .tabBar, .navigationBar)
    }
    .fullScreenCover(item: $store.scope(state: \.folderCreate, action: \.folderCreate)) {
      FolderCreateView(store: $0)
    }
  }
  
}

private extension FolderHomeView {
  
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
            Image(.Plus)
              .resizable()
              .renderingMode(.template)
              .frame(width: 30, height: 30)
              .foregroundStyle(.blue)
            
            Text("New folder", bundle: .module)
              .font(.body)
              .foregroundStyle(.blue)
          }
          .frame(maxWidth: .infinity, minHeight: 100)
          .padding(.horizontal, 20)
          .padding(.vertical, 20)
          .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
              .fill(Color.blue.opacity(0.2))
          )
        }
        
        ForEach(folders) { folder in
          NavigationLink(state: FolderDetailViewStore.State(folder: folder)) {
            HStack {
              VStack(spacing: 12) {
                Image(.FolderFill)
                  .resizable()
                  .renderingMode(.template)
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 45, height: 45)
                  .foregroundStyle(Color(hexOrPrimary: folder.hexColor))
                
                VStack(spacing: 3) {
                  Text(folder.title.orEmpty)
                    .font(.headline)
                    .foregroundStyle(Color(uiColor: .label))
                  
                  Text("\((folder.todos ?? []).count) todos", bundle: .module)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
                }
              }
            }
            .frame(maxWidth: .infinity, minHeight: 100)
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background(
              RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.secondarySystemBackground)
            )
          }
        }
        
        NavigationLink(state: FolderDetailViewStore.State(folder: nil)) {
          HStack {
            VStack(spacing: 12) {
              Image(.FolderFill)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
                .foregroundStyle(.gray)
              
              VStack(spacing: 3) {
                Text("None", bundle: .module)
                  .font(.headline)
                  .foregroundStyle(Color(uiColor: .label))
                
                Text("\(emptyFolderTodos.count) todos", bundle: .module)
                  .font(.caption)
                  .foregroundStyle(Color.gray)
              }
            }
          }
          .frame(maxWidth: .infinity, minHeight: 100)
          .padding(.horizontal, 20)
          .padding(.vertical, 20)
          .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
              .fill(Color.secondarySystemBackground)
          )
        }
      }
      .padding(.vertical, 20)
    }
  }
  
  func listGridItems() -> [GridItem] {
    if UIDevice.current.isPhone {
      return [GridItem(spacing: 10), GridItem(spacing: 10)]
    } else {
      return [GridItem(spacing: 10), GridItem(spacing: 10), GridItem(spacing: 10)]
    }
  }
  
}

#Preview {
  let container = ModelContainer.preview()
  
  return FolderHomeView(
    store: Store(
      initialState: FolderHomeViewStore.State()
    ) {
      FolderHomeViewStore()
    }
  )
  .modelContainer(container)
}
