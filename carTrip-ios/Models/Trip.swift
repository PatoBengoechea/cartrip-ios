//
//  Trip.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 06/12/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit
import SwiftyJSON

class Trip: NSObject {

    var idTrip: Int
    var dateInit: String
    var dateEnd: String
    var carForRoad: CarForRoad
    var owner: Int
    var originPlace: Place
    var destinyPlace: Place
    var shared: Bool
    var passengers: [User]
    
    init(from json: JSON) {
        idTrip = json["idTrip"].int ?? 0
        dateInit = json["dateInit"].string ?? ""
        dateEnd = json["dateEnd"].string ?? ""
        carForRoad = CarForRoad(withJSON: json["carForRoad"])
        owner = json["owner"].int ?? 0
        originPlace = Place(json: json["origin"])
        destinyPlace = Place(json: json["destiny"])
        shared = json["shared"].bool!
        passengers = User.parse(fromJSONArray: json["users"].array ?? [])
    }
    
    static func parse(jsonArray: [JSON]) -> [Trip] {
        return jsonArray.compactMap { Trip(from: $0)}
    }
}
