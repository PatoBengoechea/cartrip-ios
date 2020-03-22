//
//  HomeViewController.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 20/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController {

    //MARK: - @IBOutlet
    @IBOutlet var mapView: MKMapView!
    var locationManager = CLLocationManager.init()
    
    //MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
    }
}

extension HomeViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.setCenter(userLocation.coordinate, animated: true)
    }
}
