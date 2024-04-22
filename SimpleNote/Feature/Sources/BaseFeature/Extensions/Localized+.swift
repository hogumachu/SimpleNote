//
//  Localized+.swift
//
//
//  Created by 홍성준 on 4/23/24.
//

import Foundation

/// NSLocalizedString의 comment를 없앤 메서드
/// NSLocalizedString보다 간략하게 사용할 수 있음
public func LocalString(_ key: String, bundle: Bundle, comment: String = "") -> String {
  return NSLocalizedString(key, bundle: bundle, comment: comment)
}
