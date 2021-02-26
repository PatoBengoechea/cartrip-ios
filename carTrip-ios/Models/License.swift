//
//  License.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 20/01/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import Foundation
import SwiftyJSON

class License: NSObject {
    var expirationDate: DateParsed?
    var expirationDateUI: String
    var isExpired: Bool
    
    init(json: JSON) {
        let date = json["expireDate"].string
        expirationDate = DateParsed(date, format: .dateWithFullTime)
        isExpired = json["isDateExpired"].bool ?? false
        
        expirationDateUI = expirationDate?.dateLong() ?? "Error al cargar fecha"
    }
}
