//
//  Localized+.swift
//
//
//  Created by 홍성준 on 5/7/24.
//

import Foundation

public func LocalString(_ key: String, bundle: Bundle, comment: String = "") -> String {
  return NSLocalizedString(key, bundle: bundle, comment: comment)
}
