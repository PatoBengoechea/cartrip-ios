//
//  CarForRoadViewModel.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 01/04/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation
import MapKit

class CarForRoadViewModel: MKPointAnnotation {
    var idCarForRoad: String?
    var available: Bool?
    var forService: Bool?
    var longitude: Double?
    var latitude: Double?
    var location: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)}
    var car: CarViewModel?
    
    override var coordinate: CLLocationCoordinate2D { get { return CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)} set { } }
    override var title: String? { get { return "\((car?.brand?.capitalized ?? "") + " " +  (car?.name?.capitalized ?? ""))"} set { }}
    
    init(_ model: CarForRoad) {
        idCarForRoad = String(describing: model.idCarForRoad)
        available = model.available
        forService = model.forService
        longitude = model.longitude
        latitude = model.latitude
        car = CarViewModel(model.car)
    }
}