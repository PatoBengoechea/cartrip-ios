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
}

extension TripManagerDelegate {
    func onRentCar() { }
    func onGetTrips(trips: [Trip]) { }
}

class TripManager: BaseManager {

    static var sharedInstance = TripManager()
    
    
    func crateTrip(delegate: TripManagerDelegate, dateInit: Date, dateFinish: Date, idCarForRoad: Int) {
        delegate.onInitService()
        ServiceManager.sharedInstance.postRentCar(dateInit: dateInit,
                                                  dateFinish: dateFinish,
                                                  idCarForRoad: idCarForRoad) {
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
    
}
