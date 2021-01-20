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
    var expirationDate: String
    var isExpired: Bool
    
    init(json: JSON) {
        expirationDate = json["expireDate"].string!
        isExpired = json["isDateExpired"].bool!
    }
}
