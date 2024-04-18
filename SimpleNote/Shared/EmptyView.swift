//
//  EmptyView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/18/24.
//

import Lottie
import SwiftUI

struct EmptyView: View {
  
  private let title: LocalizedStringResource
  private let subtitle: LocalizedStringResource
  
  init(title: String = "Empty", subtitle: String) {
    self.title = LocalizedStringResource(stringLiteral: title)
    self.subtitle =  LocalizedStringResource(stringLiteral: subtitle)
  }
  
  var body: some View {
    VStack {
      LottieView(animation: .named("empty-box"))
        .playing(loopMode: .playOnce)
        .frame(maxHeight: 250)
      
      Text(title)
        .font(.headline)
        .foregroundStyle(.foreground)
      
      Text(subtitle)
        .font(.callout)
        .foregroundStyle(.gray)
        .padding(.bottom, 40)
    }
  }
  
}
