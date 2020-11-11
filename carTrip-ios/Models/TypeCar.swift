//
//  TypeCar.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 01/04/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import SwiftyJSON
import Foundation

class TypeCar {
    var idTypeCar: Int?
    var type: String?
    var capacity: Int?
    var prizeRent: Int?
    var prizeKM: Int?
    
    init(data: JSON) {
        idTypeCar = data["idTypeCar"].int
        type = data["type"].string
        capacity = data["capacity"].int
        prizeRent = data["prizeRent"]["prize"].int
        prizeKM = data["prizeKM"]["prize"].int
    }
}
