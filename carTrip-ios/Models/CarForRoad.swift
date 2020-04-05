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
    var longitude: Double?
    var latitude: Double?
    var car: Car?
    
    init(data: JSON) {
        idCarForRoad = data["idCarForRoad"].int
        available = data["available"].int == 1 ? true : false
        forService = data["forService"].int == 1 ? true : false
        longitude = data["longitude"].double
        latitude = data["latitude"].double
        car = Car(data: data["car"])
    }
    init() {
        
    }
    
    static func parse(data: JSON) -> [CarForRoad] {
        var array = [CarForRoad]()
        for item in data.arrayValue {
            let car = CarForRoad()
            car.idCarForRoad = item["idCarForRoad"].int
            car.available = item["available"].int == 1 ? true : false
            car.forService = item["forService"].int == 1 ? true : false
            car.longitude = item["longitude"].double
            car.latitude = item["latitude"].double
            car.car = Car(data: item["car"])
            array.append(car)
        }
        return array
    }
}

