//
//  CarManager.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 01/04/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

protocol CarManagerDelegate: BaseManagerDelegate {
    func onGetCarForRoad(data: [CarForRoad])
    func onGetCarForRoad(car: CarForRoad)
}

extension CarManagerDelegate {
    func onGetCarForRoad(data: [CarForRoad]) { }
    func onGetCarForRoad(car: CarForRoad) { }
}

class CarManager: BaseManager {
    
    class var instance: CarManager {
        struct Static {
            static let instance = CarManager()
        }
        return Static.instance
    }
    
    func getCarForRoad(delegate: CarManagerDelegate) {
        delegate.onInitService()
        ServiceManager.sharedInstance.getCarForRoad(succesCallback: { data in
            delegate.onGetCarForRoad(data: data)
            delegate.onFinishedService()
        }, failureCallback: { message in
            delegate.onError(message)
            delegate.onFinishedService()
        })
    }
    
    func getCarForRoad(id: Int, delegate: CarManagerDelegate) {
        delegate.onInitService()
        ServiceManager.sharedInstance.getCarForRoad(id: id, successCallback: { (car) in
            delegate.onGetCarForRoad(car: car)
            delegate.onFinishedService()
        }) { (message) in
            delegate.onError(message)
            delegate.onFinishedService()
        }
    }
}
