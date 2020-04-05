//
//  BaseManager.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 24/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

protocol BaseManagerDelegate {
    func onInitService()
    func onFinishedService()
    func onError(_ message: String)
}

class BaseManager {
    
}
