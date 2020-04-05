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
    let presenter = HomePresenter<HomeViewController>()
    
    //MARK: - Properties
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        service()
        configureMap()
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: -32.9544955, longitude: -60.6441632)
        annotation.title = "Hello mother fucker"
//        mapView.addAnnotation(annotation)
        
        
        let disntanceSpan: CLLocationDistance = 3000
        let mapCoordinate = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: disntanceSpan, longitudinalMeters: disntanceSpan)
        mapView.setRegion(mapCoordinate, animated: true)
    }
    
    
    // MARK: - Private Functions
    private func service() {
        presenter.getCarForRoad()
    }
    
    private func configureMap() {
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.setRegion(MKCoordinateRegion(MKMapRect(x: 20, y: 20, width: 20, height: 20)), animated: true)
    }
    
    func imprimir() {
        print("Rented")
    }
}

// MARK: - Home Presenter Delegate
extension HomeViewController: HomePresenterDelegate {
    func onGetCarForRoad() {
        mapView.addAnnotations(presenter.dataCarForRoad)
    }
    
    
}

// MARK: - Map View Delegate
extension HomeViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let car = view.annotation as? CarForRoadViewModel {
            let dialog = ModalRentCar(car: car.car?.fullName ?? "" , completion: imprimir)
            dialog.present()    
        }
        mapView.deselectAnnotation(view.annotation, animated: true)
    }
    
    
}
