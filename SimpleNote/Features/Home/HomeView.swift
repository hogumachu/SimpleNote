//
//  HomeView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
  
  let store: StoreOf<HomeStore>
  
  var body: some View {
    Image("global", bundle: .main)
  }
}
