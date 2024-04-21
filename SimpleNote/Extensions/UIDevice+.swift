//
//  UIDevice+.swift
//  SimpleNote
//
//  Created by 홍성준 on 4/16/24.
//

import UIKit

extension UIDevice {
  
  var isPhone: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
  }
  
  var isPad: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
  }
  
  var isMac: Bool {
    return UIDevice.current.userInterfaceIdiom == .mac
  }
  
}
