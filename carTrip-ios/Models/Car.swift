//
//  Car.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 31/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation
import SwiftyJSON

class Car {
    var name: String?
    var brand: String?
    var type: TypeCar?
    
    init(data: JSON) {
        name = data["name"].string
        brand = data["brand"].string
        type = TypeCar(data: data["typeCar"])
    }
}
