//
//  PlaceViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 08/12/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit
import MapKit

class PlaceViewController: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet var mapView: MKMapView!
    
    var places = [Place]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.delegate = self
        mapView.addAnnotations(places)
        centerMap()
        
    }
    
    private func centerMap() {
        guard let place = places.first else { return }
        let coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        let disntanceSpan: CLLocationDistance = 3000
        let mapCoordinate = MKCoordinateRegion(center: coordinate, latitudinalMeters: disntanceSpan, longitudinalMeters: disntanceSpan)
        mapView.setRegion(mapCoordinate, animated: true)
    }
}

// MARK: - Map kit delegate
extension PlaceViewController: MKMapViewDelegate {
    
}
