//
//  PlusButton.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/21/24.
//

import ImageResourceKit
import SwiftUI

public struct PlusButton: View {
  
  private let onTapped: () -> Void
  private let hexColor: String?
  
  public init(hexColor: String? = nil, onTapped: @escaping () -> Void) {
    self.hexColor = hexColor
    self.onTapped = onTapped
  }
  
  public var body: some View {
    Button {
      onTapped()
    } label: {
      Image(.PlusCircleFill)
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(width: 50, height: 50)
    }
    .foregroundStyle(Color(hexOrPrimary: hexColor))
  }
  
}
