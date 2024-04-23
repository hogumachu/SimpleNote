//
//  QueryView.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import SwiftData
import SwiftUI

public struct QueryView<T: PersistentModel, Content: View>: View {
  
  @Query public var query: [T]
  
  private let content: ([T]) -> Content
  
  public var body: some View {
    content(query)
  }
  
  public init(
    descriptor: FetchDescriptor<T>,
    @ViewBuilder content: @escaping ([T]) -> Content
  ) {
    self._query = Query(descriptor)
    self.content = content
  }
  
}
