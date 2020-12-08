//
//  Place.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 08/12/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit
import SwiftyJSON
import MapKit

class Place: MKPointAnnotation {

    var id: String = ""
    private var _longitude: String = ""
    var longitude: Double = 0.0
    private var _latitude: String = ""
    var latitude: Double = 0.0
    var cityName: String = ""
    var location: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)}
    
    override var coordinate: CLLocationCoordinate2D { get { return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)} set { } }
    
    init(json: JSON) {
        id = json["idPlace"].string ?? ""
        _latitude = json["latitude"].string ?? ""
        _longitude = json["longitude"].string ?? ""
        cityName = json["cityName"].string ?? ""
        latitude = Double(_latitude) ?? 0.0
        longitude = Double(_longitude) ?? 0.0
        
    }
    
    static func parse(json: [JSON]) -> [Place] {
        return json.compactMap { Place(json: $0) }
    }
}
