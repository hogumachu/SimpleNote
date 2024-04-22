//
//  PlusButton.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/21/24.
//

import SwiftUI

struct PlusButton: View {
  
  private let onTapped: () -> Void
  private let hexColor: String?
  
  init(hexColor: String? = nil, onTapped: @escaping () -> Void) {
    self.hexColor = hexColor
    self.onTapped = onTapped
  }
  
  var body: some View {
    Button {
      onTapped()
    } label: {
      Image(.plusCircleFill)
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(width: 50, height: 50)
    }
    .foregroundStyle(Color(hexOrPrimary: hexColor))
  }
  
}
