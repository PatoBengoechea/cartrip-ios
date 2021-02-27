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
    func onGetCreditCard()
}

enum RentDataSource {
    case image, share, days, price, informationShare, from, to, creditCard, prizeKM
}

class RentPrenter<T: RentPresenterDelegate>: BasePresenter<T> {
    
    // MARK: - Properties
    var carShared: Bool = false
    
    var datasource: [RentDataSource] = [.image, .share, .days, .creditCard, .price]
    var currentCar: CarForRoadViewModel?
    var currentCreditCard: CreditCard?
    var amount = 0.0
    var destiny: Place?
    
    
    func getCarForRoad(id: Int) {
        CarManager.instance.getCarForRoad(id: id, delegate: self)
    }
    
    func getPlaces(name: String) {
        TripManager.sharedInstance.getPlaces(name: name, delegate: self)
    }
    
    func setDataSource(share: Bool) {
        carShared = share
        if share {
            datasource = [.image, .share, .informationShare, .from, .to, .creditCard, .prizeKM]
        } else {
            datasource = [.image, .share, .days, .creditCard, .price]
        }
    }
    
    func getOneCreditCard() {
        guard let id = UserDefaults.standard.string(forKey: "idUser") else { return }
        CreditCardManager.shared.getOneCreditCard(id: id, delegate: self)
    }
    
    func createTrip(dateInit: Date, dateFinish: Date?, idDestiny: Int?) {
        let dateInit2 = dateInit.dateToString()
        let dateFinish = dateFinish?.dateToString() ?? dateInit.dateToString()
        let idCardForRoad = currentCar?.idCarForRoad ?? 0
        let owner = UserDefaults.standard.string(forKey: "idUser") ?? "0"
        let latitudeOrigin = currentCar?.latitude ?? 0.0
        let longitudeOrigin = currentCar?.longitude ?? 0.0
        let idPlaceGivenBack = destiny?.id ?? 0
        let idCreditCard = currentCreditCard?.idCreditCard
        
        let inputModel = TripInputModel(dateInit: dateInit2,
                                        dateFinish: dateFinish,
                                        idCarForRoad: idCardForRoad,
                                        owner: owner,
                                        latitudeOrigin: latitudeOrigin,
                                        longitudeOrigin: longitudeOrigin,
                                        idPlaceGivenBack: idPlaceGivenBack,
                                        shared: carShared,
                                        idDestiny: idDestiny ?? 0,
                                        idCreditCard: idCreditCard,
                                        amount: amount)
        
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

// MARK: - Credit Card Manager
extension RentPrenter: CreditCardManagerDelegate {
    func onGetCreditCard(card: CreditCard) {
        self.currentCreditCard = card
        delegate?.onGetCreditCard()
    }
}
