//
//  NavigationBar.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/21/24.
//

import SwiftUI

public enum NavigationBarStyle {
  case back
  case close
  case titleOnly(String)
  case titleWithButton(String, ImageResource)
}

public struct NavigationBar: View {
  
  private let style: NavigationBarStyle
  private let onTapped: (() -> Void)?
  
  public init(style: NavigationBarStyle, onTapped: (() -> Void)? = nil) {
    self.style = style
    self.onTapped = onTapped
  }
  
  public var body: some View {
    HStack {
      switch style {
      case .back:
        Button {
          onTapped?()
        } label: {
          Image(.ArrowLeft)
            .resizable()
            .renderingMode(.template)
            .frame(width: 30, height: 30)
            .foregroundStyle(.foreground)
        }
        
        Spacer()
        
      case .close:
        Spacer()
        
        Button {
          onTapped?()
        } label: {
          Image(.Xmark)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)
            .foregroundStyle(.foreground)
        }
        
      case let .titleOnly(title):
        Text(title)
          .font(.headline)
        
        Spacer()
        
      case let .titleWithButton(title, image):
        Text(title)
          .font(.headline)
        
        Spacer()
        
        Button {
          onTapped?()
        } label: {
          Image(image)
            .resizable()
            .renderingMode(.template)
            .frame(width: 30, height: 30)
            .foregroundStyle(.foreground)
        }
      }
    }
    .frame(height: 50)
  }
  
}
