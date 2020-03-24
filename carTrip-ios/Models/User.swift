//
//  User.swift
//  carTrip-ios
//
//  Created by Patricio Bengoechea on 24/03/2020.
//  Copyright © 2020 Patricio Bengoechea. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON


class User: Object {
    @objc dynamic var idUser = 0
    @objc dynamic var nameUser: String?
    @objc dynamic var lastNameUser: String?
    @objc dynamic var email: String?
    @objc dynamic var password: String?
    @objc dynamic var dni: String?
    @objc dynamic var birthDate: String?
    
    init(data: JSON) {
        idUser = data["iduser"].int ?? 0
        dni = data["dni"].string ?? nil
        password = data["password"].string
        nameUser = data["name"].string
        birthDate = data["birthdate"].string
        email = data["email"].string
        lastNameUser = data["lastname"].string
    }
    
    
    required init() {
        
    }
}

