//
//  FolderView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import SwiftUI

struct FolderView: View {
  
  private let folder: Folder
  private var onTapped: (Folder) -> Void
  
  init(
    folder: Folder,
    onTapped: @escaping (Folder) -> Void
  ) {
    self.folder = folder
    self.onTapped = onTapped
  }
  
  var body: some View {
    HStack {
      Image(.folderFill)
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(width: 30, height: 30)
        .foregroundStyle(Color(hexOrGray: folder.hexColor))
      
      VStack(alignment: .leading) {
        if let title = folder.title {
          Text(title)
            .font(.body)
            .foregroundStyle(.foreground)
        } else {
          Text("None")
            .font(.body)
            .foregroundStyle(.foreground)
        }
        
        Text("\((folder.todos ?? []).count) todos")
          .font(.caption)
          .foregroundStyle(Color.gray)
      }
      
      Spacer()
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 16)
        .foregroundStyle(Color.secondarySystemBackground)
    )
    .onTapGesture {
      onTapped(folder)
    }
  }
  
}
