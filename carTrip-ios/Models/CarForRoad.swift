//
//  CarForRoad.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 31/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation
import SwiftyJSON

class CarForRoad {
    var idCarForRoad: Int?
    var available: Bool?
    var forService: Bool?
    var longitude: String
    var latitude: String
    var car: Car?
    
    init(withJSON data: JSON) {
        idCarForRoad = data["idCarForRoad"].int
        available = data["available"].int == 1 ? true : false
        forService = data["forService"].int == 1 ? true : false
        longitude = data["longitude"].string ?? ""
        latitude = data["latitude"].string ?? ""
        car = Car(data: data["car"])
    }

    
    static func parse(data: [JSON]) -> [CarForRoad] {
        return data.compactMap { CarForRoad(withJSON: $0)}
        
    }
}

