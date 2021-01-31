//
//  TripInputModel.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 31/12/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

class TripInputModel: NSObject {
    var dateInit: String
    var dateFinish: String
    var idCarForRoad: Int
    var owner: String
    var latitudeOrigin: Double
    var longitudeOrigin: Double
    var idPlaceGivenBack: Int
    var shared: Bool
    var idDestiny: String?
    
    init(dateInit: String, dateFinish: String, idCarForRoad: Int, owner: String, latitudeOrigin: Double, longitudeOrigin: Double, idPlaceGivenBack: Int, shared: Bool, idDestiny: String? = nil) {
        self.dateInit = dateInit
        self.dateFinish = dateFinish
        self.idCarForRoad = idCarForRoad
        self.owner = owner
        self.latitudeOrigin = latitudeOrigin
        self.longitudeOrigin = longitudeOrigin
        self.idDestiny = idDestiny
        self.idPlaceGivenBack = idPlaceGivenBack
        self.shared = shared
    }
}
