//
//  Brother.swift
//  embri
//
//  Created by Robert Lynch on 7/6/23.
//

import Foundation
import SwiftUI
import SwiftyJSON

class Brother: ObservableObject {
  
  let threads: [Thread]

  init() {
    let path = Bundle.main.path(forResource: "brother", ofType: "json")!
    let data = NSData(contentsOfFile: path)!
    let json = try! JSON(data: data as Data)
    self.threads = json.map { (_, item) in Thread(from: item) }
  }
}
