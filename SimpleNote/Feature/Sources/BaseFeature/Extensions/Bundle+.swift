//
//  Bundle+.swift
//
//
//  Created by 홍성준 on 4/23/24.
//

import Foundation

public extension Bundle {
  
  static var base: Bundle {
    Bundle.module
  }
  
}

public extension URL {
  
  static var baseModule: URL {
    Bundle.module.bundleURL
  }
  
}
