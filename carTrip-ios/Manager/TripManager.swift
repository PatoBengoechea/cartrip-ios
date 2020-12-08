//
//  TripManager.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 06/12/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import UIKit

protocol TripManagerDelegate: BaseManagerDelegate {
    func onRentCar()
    func onGetTrips(trips: [Trip])
    func onGetActualTrip(trip: Trip?)
    func onGetPlaces(places: [Place])
}

extension TripManagerDelegate {
    func onRentCar() { }
    func onGetTrips(trips: [Trip]) { }
    func onGetActualTrip(trip: Trip?) {  }
    func onGetPlaces(places: [Place]) { }
}

class TripManager: BaseManager {

    static var sharedInstance = TripManager()
    
    
    func crateTrip(delegate: TripManagerDelegate, dateInit: Date, dateFinish: Date, idCarForRoad: Int, latitudeOrigin: Double, longitudeOrigin: Double) {
        delegate.onInitService()
        ServiceManager.sharedInstance.postRentCar(dateInit: dateInit,
                                                  dateFinish: dateFinish,
                                                  idCarForRoad: idCarForRoad,
                                                  latitudeOrigin: latitudeOrigin,
                                                  longitudeOrigin: longitudeOrigin) {
            delegate.onRentCar()
            delegate.onFinishedService()
        } failureCallback: { (message) in
            delegate.onError(message)
            delegate.onFinishedService()
        }
    }
    
    func getTrips(delegate: TripManagerDelegate, id: Int) {
        delegate.onInitService()
        ServiceManager.sharedInstance.getTrips(id: id) { (trips) in
            delegate.onGetTrips(trips: trips)
            delegate.onFinishedService()
        } failureCallback: { (message) in
            delegate.onError(message)
            delegate.onFinishedService()
        }
    }
    
    func getActualTrip(delegate: TripManagerDelegate) {
        if let id = UserDefaults.standard.string(forKey: "idUser") {
            delegate.onInitService()
            ServiceManager.sharedInstance.getActualTrip(id: id) { (trip) in
                delegate.onGetActualTrip(trip: trip)
                delegate.onFinishedService()
            } failureCallback: { (message) in
                delegate.onError(message)
                delegate.onFinishedService()
            }

        } else {
            delegate.onError("User not found")
        }
    }
    
    func getPlaces(name: String, delegate: TripManagerDelegate) {
        delegate.onInitService()
        ServiceManager.sharedInstance.getPlaces(name: name) { places in
            delegate.onGetPlaces(places: places)
            delegate.onFinishedService()
        } failureCallback: { message in
            delegate.onFinishedService()
            delegate.onError(message)
        }
    }
}
