//
//  BasePresenter.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 17/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

protocol BasePresenterDelegate: AnyObject {
    func startLoading()
    func finishedLoading()
    func onError(message: String)
}


extension BasePresenterDelegate {
    func startLoading() { }
    func finishedLoading() { }
    func onError(message: String) { }
}



class BasePresenter<T: BasePresenterDelegate> {
    weak internal var delegate: T?
    
    func attachView(_ view: T) {
        self.delegate = view
    }
}
