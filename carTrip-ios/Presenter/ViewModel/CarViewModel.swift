//
//  CarViewModel.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 01/04/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

struct CarViewModel {
    var name: String?
    var brand: String?
    var fullName: String { return "\(brand!) \(name!)"  }
    var type: TypeCarViewModel?
    
    init(_ model: Car?) {
        name = model?.name
        brand = model?.brand
        type = TypeCarViewModel(model?.type)
    }
}
