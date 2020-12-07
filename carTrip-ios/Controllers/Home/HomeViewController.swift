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
    @IBOutlet var menuView: UIView!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var routeView: UIView!
    @IBOutlet var routeButton: UIButton!
    @IBOutlet var carView: UIView!
    @IBOutlet var carButton: UIButton!
    @IBOutlet var profileView: UIView!
    @IBOutlet var profileButton: UIButton!
    @IBOutlet var positionView: UIView!
    @IBOutlet var positionButton: UIButton!
    
    @IBOutlet var routeBotton: NSLayoutConstraint!
    @IBOutlet var profileTrailing: NSLayoutConstraint!
    @IBOutlet var carTrailing: NSLayoutConstraint!
    @IBOutlet var carBottom: NSLayoutConstraint!
    
    //MARK: - Properties
    var locationManager = CLLocationManager.init()
    let presenter = HomePresenter<HomeViewController>()
    var menuVisible: Bool = false { willSet { menu() }}
    weak var rootDelegate: RootViewControllerDelegate?
    private var selectedCar: CarForRoadViewModel?
    
    // MARK: - @IBAction
    @IBAction private func menuButtonTapped() {
        menuVisible = !menuVisible
        UIView.animate(withDuration: 0.1, animations: {
            self.menuView.backgroundColor = .white
            self.menuButton.tintColor = .blueCar
        }) { (_) in
            UIView.animate(withDuration: 0.1) {
                self.menuView.backgroundColor = .blueCar
                self.menuButton.tintColor = .white
            }
        }
    }
    
    @IBAction private func positionButtonTapped() {
        UIView.animate(withDuration: 0.1, animations: {
            self.positionButton.tintColor = .white
            self.positionView.backgroundColor = .black
        }) { (_) in
            self.centerMap()
            self.service()
            UIView.animate(withDuration: 0.1) {
                self.positionButton.tintColor = .black
                self.positionView.backgroundColor = .white
            }
        }
    }
    
    @IBAction private func userButtonTapped() {
        UIView.animate(withDuration: 0.1, animations: {
            self.profileButton.tintColor = .white
            self.profileView.backgroundColor = .systemRed
        }) { (_) in
            self.performSegue(withIdentifier: R.segue.homeViewController.goToProfile.identifier, sender: nil)
            UIView.animate(withDuration: 0.1) {
                self.profileButton.tintColor = .systemRed
                self.profileView.backgroundColor = .white
            }
        }
    }
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        configureMap()
        configureView()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        menuView.addShadowAndCornerRadius(cornerRadius: menuView.frame.width/2, color: .darkGray)
        routeView.addShadowAndCornerRadius(cornerRadius: routeView.frame.width/2, color: .darkGray)
        carView.addShadowAndCornerRadius(cornerRadius: carView.frame.width/2, color: .darkGray)
        profileView.addShadowAndCornerRadius(cornerRadius: profileView.frame.width/2, color: .darkGray)
        positionView.addShadowAndCornerRadius(cornerRadius: positionView.frame.width/2, color: .darkGray)
//        contractMenu()
        
        menuView.layoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        service()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.routeView.alpha = 0
        self.routeButton.alpha = 0
        
        self.carView.alpha = 0
        self.carButton.alpha = 0
        
        self.profileView.alpha = 0
        self.profileButton.alpha = 0
        routeBotton.constant = -30
        profileTrailing.constant = -30
        carTrailing.constant = -30
        carBottom.constant = -30
        
        view.layoutIfNeeded()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let rentVC = segue.destination as? RentViewController, let car = sender as? CarForRoadViewModel {
            rentVC.currentCar = car
        }
    }
    
    // MARK: - Private Functions
    private func service() {
        mapView.removeAnnotations(presenter.dataCarForRoad)
        presenter.getCarForRoad()
    }
    
    private func configureMap() {
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
        
        centerMap()
    }
    
    private func configureView() {
        menuView.backgroundColor = .blueCar
        menuButton.tintColor = .white
        
        routeView.backgroundColor = .primaryGreen
        routeButton.tintColor = .white
        
        carView.backgroundColor = .systemYellow
        carButton.tintColor = .white
        
        profileView.backgroundColor = .systemRed
        profileButton.tintColor = .white
        
        positionView.backgroundColor = .white
        positionButton.tintColor = .black
    }
    
    private func contractMenu() {
//        menuVisible = !menuVisible
        routeBotton.constant = -30
        profileTrailing.constant = -30
        carTrailing.constant = -30
        carBottom.constant = -30
        
        UIView.animate(withDuration: 0.5,
                              delay: 0,
                              usingSpringWithDamping: 1,
                              initialSpringVelocity: 1,
                              options: .curveEaseInOut,
                              animations: {
                                self.view.layoutIfNeeded()
                                
                                self.routeView.alpha = 0
                                self.routeButton.alpha = 0
                                
                                self.carView.alpha = 0
                                self.carButton.alpha = 0
                                
                                self.profileView.alpha = 0
                                self.profileButton.alpha = 0
               }) { (_) in
                
                self.routeView.isHidden = true
                self.routeButton.isHidden = true
                
                self.carView.isHidden = true
                self.carButton.isHidden = true
                
                self.profileView.isHidden = true
                self.profileButton.isHidden = true
               }
        
        
    }
    
    private func showMenu() {

        routeBotton.constant = 40
        profileTrailing.constant = 40
        carTrailing.constant = 15
        carBottom.constant = 15
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut,
                       animations: {
                        self.view.layoutIfNeeded()
                        
                        self.routeView.appear()
                        self.routeButton.appear()

                        self.carView.appear()
                        self.carButton.appear()

                        self.profileView.appear()
                        self.profileButton.appear()
                        
        }) { (_) in
        }
    }
    
    private func menu() {
        menuVisible ? contractMenu() : showMenu()
    }
    
    private func centerMap() {
        let coordinate = CLLocationCoordinate2D(latitude: -32.9544955, longitude: -60.6441632)
        let disntanceSpan: CLLocationDistance = 3000
        let mapCoordinate = MKCoordinateRegion(center: coordinate, latitudinalMeters: disntanceSpan, longitudinalMeters: disntanceSpan)
        mapView.setRegion(mapCoordinate, animated: true)
    }
    
    func goToRent() {
        performSegue(withIdentifier: R.segue.homeViewController.goToRent.identifier, sender: selectedCar)
    }
}

// MARK: - Home Presenter Delegate
extension HomeViewController: HomePresenterDelegate {
    func onGetCarForRoad() {
        mapView.addAnnotations(presenter.dataCarForRoad)
    }
    
    func startLoading() {
        Loader.showLoader()
    }
    
    func finishedLoading() {
        Loader.dismiss()
    }
    
    
}

// MARK: - Map View Delegate
extension HomeViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let car = view.annotation as? CarForRoadViewModel {
            selectedCar = car
            let dialog = ModalRentCar(car: car , completion: goToRent)
            dialog.present()    
        }
        mapView.deselectAnnotation(view.annotation, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if menuVisible {
            menuVisible = false
        }
    }
    
}
