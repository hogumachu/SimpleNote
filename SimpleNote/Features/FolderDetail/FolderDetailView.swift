//
//  FolderDetailView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/15/24.
//

import ComposableArchitecture
import SwiftUI

struct FolderDetailView: View {
  
  @Bindable var store: StoreOf<FolderDetailViewStore>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      
    }
  }
  
}
