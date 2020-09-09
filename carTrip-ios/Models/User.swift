//
//  User.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 24/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation
import SwiftyJSON


class User: NSObject {
    var idUser = 0
    var nameUser: String?
    var lastNameUser: String?
    var email: String?
    var password: String?
    var dni: String?
    var birthDate: String?
    
    init(data: JSON) {
        idUser = data["iduser"].int ?? 0
        dni = data["dni"].string ?? nil
        password = data["password"].string
        nameUser = data["name"].string
        birthDate = data["birthdate"].string
        email = data["email"].string
        lastNameUser = data["lastname"].string
    }
}

