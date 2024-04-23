//
//  FolderView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import Entity
import SwiftUI

public struct FolderView: View {
  
  private let folder: Folder
  private var onTapped: (Folder) -> Void
  
  public init(
    folder: Folder,
    onTapped: @escaping (Folder) -> Void
  ) {
    self.folder = folder
    self.onTapped = onTapped
  }
  
  public var body: some View {
    HStack {
      Image(.FolderFill)
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
          Text("None", bundle: .module)
            .font(.body)
            .foregroundStyle(.foreground)
        }
        
        Text("\((folder.todos ?? []).count) todos", bundle: .module)
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
