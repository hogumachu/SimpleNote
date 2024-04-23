//
//  Optional+OrEmpty.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/19/24.
//

import Foundation

public extension Optional where Wrapped == String {
  
  var orEmpty: String {
    switch self {
    case let .some(value):
      return value
    case .none:
      return ""
    }
  }
  
}

public extension Optional where Wrapped == Date {
  
  var orNow: Date {
    switch self {
    case let .some(value):
      return value
    case .none:
      return .now
    }
  }
  
}

public extension Optional where Wrapped == Bool {
  
  var orTrue: Bool {
    switch self {
    case let .some(value):
      return value
    case .none:
      return true
    }
  }
  
  var orFalse: Bool {
    switch self {
    case let .some(value):
      return value
    case .none:
      return false
    }
  }
  
}

public extension Optional where Wrapped == UUID {
  
  var orRandom: UUID {
    switch self {
    case let .some(value):
      return value
    case .none:
      return .init()
    }
  }
  
}
