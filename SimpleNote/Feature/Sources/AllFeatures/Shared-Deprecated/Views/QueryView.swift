//
//  QueryView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import SwiftData
import SwiftUI

struct QueryView<T: PersistentModel, Content: View>: View {
  
  @Query var query: [T]
  
  let content: ([T]) -> Content
  
  var body: some View {
    content(query)
  }
  
  init(
    descriptor: FetchDescriptor<T>,
    @ViewBuilder content: @escaping ([T]) -> Content
  ) {
    self._query = Query(descriptor)
    self.content = content
  }
  
}
