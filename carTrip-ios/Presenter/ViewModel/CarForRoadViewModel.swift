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
    var idCarForRoad: Int
    var available: Bool
    var forService: Bool
    var longitude: Double?
    var latitude: Double?
    var location: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)}
    var car: CarViewModel?
    var locationAddres: String = ""
    
    
    override var coordinate: CLLocationCoordinate2D { get { return CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)} set { } }
    override var title: String? { get { return "\((car?.brand?.capitalized ?? "") + " " +  (car?.name?.capitalized ?? ""))"} set { }}
    
    init(_ model: CarForRoad) {
        idCarForRoad = model.idCarForRoad ?? 0
        available = model.available ?? false
        forService = model.forService ?? false
        longitude = Double(model.longitude)
        latitude = Double(model.latitude)
        car = CarViewModel(model.car)
        let geoCoder = CLGeocoder()
        super.init()
        let clLocation = CLLocation(latitude: latitude ?? 0.0, longitude: longitude ?? 0.0)
        geoCoder.reverseGeocodeLocation(clLocation) { (placermarks, error) in
            guard let placeMark = placermarks?.first else { return }
            self.locationAddres = "\(placeMark.name ?? ""), \(placeMark.locality ?? "")"
        }
    }
}
