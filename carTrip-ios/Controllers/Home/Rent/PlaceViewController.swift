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
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    var places = [Place]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.delegate = self
        mapView.addAnnotations(places)
        centerMap()
        customize()
    }
    
    // MARK: - @IBAction
    @IBAction func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Functions
    private func centerMap() {
        guard let place = places.first else { return }
        let coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        let disntanceSpan: CLLocationDistance = 10000
        let mapCoordinate = MKCoordinateRegion(center: coordinate, latitudinalMeters: disntanceSpan, longitudinalMeters: disntanceSpan)
        mapView.setRegion(mapCoordinate, animated: true)
    }
    
    private func customize() {
        navigationView.alpha = 0.9
        closeButton.setTitle(R.string.localizable.close(), for: .normal)
        closeButton.setTitleColor(.blueCar, for: .normal)
    }
}

// MARK: - Map kit delegate
extension PlaceViewController: MKMapViewDelegate {
    
}
