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
    
    init(_ model: TypeCar?) {
        idTypeCar = String(describing: model?.idTypeCar)
        type = model?.type
        capacity = model?.capacity
    }
}
