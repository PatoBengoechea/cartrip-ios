//
//  RentPresenter.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 21/09/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

protocol RentPresenterDelegate: BasePresenterDelegate {
    func onGetCarForRoad()
    func onRentCar()
}

enum RentDataSource {
    case image, share, days, price
}

class RentPrenter<T: RentPresenterDelegate>: BasePresenter<T> {
    
    // MARK: - Properties
    
    var datasource: [RentDataSource] = [.image, .share, .days, .price]
    var currentCar: CarForRoadViewModel?
    
    
    func getCarForRoad(id: Int) {
        CarManager.instance.getCarForRoad(id: id, delegate: self)
    }
    
    func setDataSource(share: Bool) {
        if share {
            datasource = [.image, .share]
        } else {
            datasource = [.image, .share, .days, .price]
        }
    }
    
    func createTrip(dateInit: Date, dateFinish: Date?) {
        if let finish = dateFinish, let idCarForRoad = currentCar?.idCarForRoad {
            TripManager.sharedInstance.crateTrip(delegate: self, dateInit: dateInit, dateFinish: finish, idCarForRoad: idCarForRoad)
        } else {
            delegate?.onError(message: "Please try again")
        }
        
    }
}

// MARK: - Car Manager Delegate
extension RentPrenter: CarManagerDelegate {
    func onInitService() {
        delegate?.startLoading()
    }
    
    func onFinishedService() {
        delegate?.finishedLoading()
    }
    
    func onError(_ message: String) {
        delegate?.onError(message: message)
    }
    
    
    func onGetCarForRoad(car: CarForRoad) {
        currentCar = CarForRoadViewModel(car)
        delegate?.onGetCarForRoad()
    }
}

// MARK: - Trip Manager Delegate
extension RentPrenter: TripManagerDelegate {
    func onRentCar() {
        delegate?.onRentCar()
    }
    
    
}
