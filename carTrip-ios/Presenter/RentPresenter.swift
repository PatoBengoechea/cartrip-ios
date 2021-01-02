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
    func onGetPlaces(places: [Place])
}

enum RentDataSource {
    case image, share, days, price, informationShare, from, to
}

class RentPrenter<T: RentPresenterDelegate>: BasePresenter<T> {
    
    // MARK: - Properties
    
    var datasource: [RentDataSource] = [.image, .share, .days, .price]
    var currentCar: CarForRoadViewModel?
    
    
    func getCarForRoad(id: Int) {
        CarManager.instance.getCarForRoad(id: id, delegate: self)
    }
    
    func getPlaces(name: String) {
        TripManager.sharedInstance.getPlaces(name: name, delegate: self)
    }
    
    func setDataSource(share: Bool) {
        if share {
            datasource = [.image, .share, .informationShare, .from, .to]
        } else {
            datasource = [.image, .share, .days, .price]
        }
    }
    
    func createTrip(dateInit: Date, dateFinish: Date?, idDestiny: String?) {
        let inputModel = TripInputModel(dateInit: dateInit.dateToString(),
                                        dateFinish: dateFinish?.dateToString() ?? dateInit.dateToString(),
                                        idCarForRoad: currentCar?.idCarForRoad ?? 0,
                                        owner: UserDefaults.standard.string(forKey: "idUser") ?? "0",
                                        latitudeOrigin: currentCar?.latitude ?? 0.0,
                                        longitudeOrigin: currentCar?.longitude ?? 0.0,
                                        idDestiny: idDestiny)
        
        TripManager.sharedInstance.crateTrip(delegate: self, input: inputModel)
        
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
    
    func onGetPlaces(places: [Place]) {
        delegate?.onGetPlaces(places: places)
    }
}

// MARK: - Trip Manager Delegate
extension RentPrenter: TripManagerDelegate {
    func onRentCar() {
        delegate?.onRentCar()
    }
    
    
}
