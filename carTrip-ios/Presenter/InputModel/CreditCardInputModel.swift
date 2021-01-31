//
//  CreditCardInputModel.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 30/01/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import Foundation


struct CreditCardInputModel {
    var idUser: String
    public var holderName: String
    public var number: String
    public var monthExpiration: Int
    public var yearExpiration: Int
    public var ccv: String
    
    init(holder: String, number: String, monthExpiration month: Int, yearExpiration year: Int, ccv: String) {
        self.holderName = holder
        self.number = number
        self.monthExpiration = month
        self.yearExpiration = year
        self.ccv = ccv
        self.idUser = UserDefaults.standard.string(forKey: "idUser")!
    }
    
}
