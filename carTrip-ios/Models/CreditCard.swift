//
//  CreditCard.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 31/01/2021.
//  Copyright © 2021 Patricio Bengoechea. All rights reserved.
//

import Foundation
import SwiftyJSON

class CreditCard: NSObject {
    var idCreditCard: Int
    var idUser: Int
    var holderName: String
    var number: String
    var monthExpiration: Int
    var yearExpiration: Int
    var ccv: String
    
    override init() {
        self.idCreditCard = 999999
        self.idUser = 0
        self.number = ""
        self.holderName = ""
        self.monthExpiration = 1
        self.yearExpiration = 1
        self.ccv = "xxx"
    }
    
    
    init(json: JSON) {
        self.idCreditCard = json["idCreditCard"].int!
        self.idUser = json["idUser"].int!
        self.number = json["creditCardNumber"].string!
        self.holderName = json["holderName"].string!
        self.monthExpiration = json["monthExpiration"].int!
        self.yearExpiration = json["yearExpiration"].int!
        self.ccv = json["ccv"].string!
    }
    
    static func parse(jsonArray array: [JSON]) -> [CreditCard] {
        return array.compactMap{CreditCard(json: $0)}
    }
    
}
