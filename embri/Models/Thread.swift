//
//  Thread.swift
//  embri
//
//  Created by Robert Lynch on 7/6/23.
//

import Foundation
import SwiftUI
import SwiftyJSON

struct Thread: Identifiable {
  var id: String
  var name: String
  var color: Color
  
  init(from json: JSON) {
    self.id = json["id"].stringValue
    self.name = json["name"].stringValue
    self.color = Color(
      red: json["color"]["r"].doubleValue / 255,
      green: json["color"]["g"].doubleValue / 255,
      blue: json["color"]["b"].doubleValue / 255
    )
  }
}

