//
//  TypeCarViewModel.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 01/04/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

struct TypeCarViewModel {
    
    var idTypeCar: String?
    var type: String?
    var capacity: Int?
    var prizeRent: Int
    var prizeKM: Int
    var prizeRentUI: String { return "$\(prizeRent)"}
    var prizeKMUI: String { return "$\(prizeKM)"}
    
    init(_ model: TypeCar?) {
        idTypeCar = String(describing: model?.idTypeCar)
        type = model?.type
        capacity = model?.capacity
        prizeRent = model?.prizeRent ?? 0
        prizeKM = model?.prizeKM ?? 0
    }
    
    func getRentPricePerDays(days: Int) -> String {
        let total = days*prizeRent
        return "$\(total)"
    }
    
    func getKMPrice(km: Int) -> String {
        let total = km*prizeKM
        return "$\(total)"
    }
 }
