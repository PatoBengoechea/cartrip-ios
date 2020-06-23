//
//  UserInputModel.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 17/06/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation

struct UserInputModel {
    var email: String?
    var password: String?
    var name: String?
    var lastName: String?
    var dni: String?
    private var _birthdate: Date?
    var birthDate: String?  { return _birthdate?.dateToString() }
    
    init() {
        
    }
    mutating func setBirthDate(date: Date) {
        _birthdate = date
    }
    
}
