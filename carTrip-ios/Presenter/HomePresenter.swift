//
//  HomePresenter.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 01/04/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

protocol HomePresenterDelegate: BasePresenterDelegate {
    func onGetCarForRoad()
    func onGetActualTrip(trip: Trip?)
    
}

class HomePresenter<T: HomePresenterDelegate>: BasePresenter<T> {
    
    // MARK: - Properties
    var dataCarForRoad = [CarForRoadViewModel]()
    
    func getCarForRoad() {
        CarManager.instance.getCarForRoad(delegate: self)
    }
    
    func checkActualTrip() {
        TripManager.sharedInstance.getActualTrip(delegate: self)
    }
    
}


extension HomePresenter: CarManagerDelegate {
    func onGetCarForRoad(data: [CarForRoad]) {
        dataCarForRoad = data.map {
            return CarForRoadViewModel($0)
        }
        delegate?.onGetCarForRoad()
    }
    
    func onInitService() {
        delegate?.startLoading()
    }
    
    func onFinishedService() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.delegate?.finishedLoading()
        }
    }
    
    func onError(_ message: String) {
        delegate?.onError(message: message)
    }
    
    
}

extension HomePresenter: TripManagerDelegate {
    func onGetActualTrip(trip: Trip?) {
        delegate?.onGetActualTrip(trip: trip)
    }
}
